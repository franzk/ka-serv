import { SMTPServer } from "smtp-server";
import { simpleParser } from "mailparser";
import axios from "axios";
import dotenv from "dotenv";

dotenv.config();

async function getAccessToken() {
	const res = await axios.post(
		process.env.KEYCLOAK_TOKEN_URL,
		new URLSearchParams({
			grant_type: "client_credentials",
			client_id: process.env.CLIENT_ID,
			client_secret: process.env.CLIENT_SECRET,
		}),
		{ headers: { "Content-Type": "application/x-www-form-urlencoded" } }
	);
	return res.data.access_token;
}

const server = new SMTPServer({
	authOptional: true,
	onData(stream, session, callback) {
		simpleParser(stream)
			.then(async (parsed) => {
				console.log("📧 Received email:", parsed.from, parsed.subject);

				const payload = {
					from: parsed.from?.text,
					to: parsed.to?.text,
					subject: parsed.subject,
					text: parsed.text,
					html: parsed.html,
				};

				try {
					const token = await getAccessToken();
					await axios.post(process.env.MAILER_URL, payload, {
						headers: { Authorization: `Bearer ${token}` },
					});
					console.log(`✅ Mail forwarded to API: ${payload.subject}`);
					callback();
				} catch (err) {
					console.error("❌ Error forwarding email:", err);
					callback(err);
				}
			})
			.catch((err) => {
				console.error("❌ Mail parsing error:", err);
				callback(err);
			});
	},
});

server.listen(1025, () => {
	console.log("📨 SMTP Gateway listening on port 1025");
});
