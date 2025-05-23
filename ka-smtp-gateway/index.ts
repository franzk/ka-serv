import { SMTPServer, SMTPServerDataStream } from 'smtp-server'
import { simpleParser } from 'mailparser'
import axios from 'axios'
import dotenv from 'dotenv'
import { ParsedMail } from 'mailparser'

interface MailDetails {
  from: string
  to: string
  subject: string
  text: string
  html: string
}

dotenv.config()

/**
 * SMTP server to receive emails and forward them to the API
 */
const server = new SMTPServer({
  authOptional: true,
  onData(stream, session, callback) {
    handleRequest(stream)
      .then(() => callback())
      .catch((err) => callback(err))
  }
})

server.listen(1025, () => {
  if (!process.env.MAILER_URL) {
    throw new Error('MAILER_URL is not set')
  }
  console.log('📨 SMTP Gateway listening on port 1025')
})

/**
 * Get access token from Keycloak
 * @returns {string} Access token for Keycloak
 */
async function getAccessToken() {
  if (!process.env.KEYCLOAK_TOKEN_URL || !process.env.CLIENT_ID || !process.env.CLIENT_SECRET) {
    throw new Error('Missing Keycloak configuration')
  }
  const res = await axios.post(
    process.env.KEYCLOAK_TOKEN_URL,
    new URLSearchParams({
      grant_type: 'client_credentials',
      client_id: process.env.CLIENT_ID,
      client_secret: process.env.CLIENT_SECRET
    }),
    { headers: { 'Content-Type': 'application/x-www-form-urlencoded' } }
  )
  return res.data.access_token
}

/**
 * Handle incoming email and forward it to the API
 * @param {SMTPServerDataStream} stream - The email stream
 */
const handleRequest = async (stream: SMTPServerDataStream) => {
  try {
    const parsed: ParsedMail = await simpleParser(stream)

    console.log('📧 Received email:', parsed.from?.text, parsed.subject)

    // process mail data
    const payload: MailDetails = {
      from: parsed.from?.text || '',
      to: Array.isArray(parsed.to)
        ? parsed.to.flatMap((addr) => addr.text).join(',')
        : parsed.to?.text || '',
      subject: parsed.subject || '',
      text: parsed.text || '',
      html: parsed.html || ''
    }

    // Get Keycloak access token
    const token = await getAccessToken()

    // Send email to API
    await axios.post(process.env.MAILER_URL!, payload, {
      headers: { Authorization: `Bearer ${token}` }
    })
    console.log(`✅ Mail forwarded to API: ${payload.subject}`)
  } catch (err) {
    console.error('❌ Error handling email:', err)
  }
}
