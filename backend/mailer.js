const nodemailer = require('nodemailer');

const sendResetEmail = async (emailUser, emailPass, to, resetLink) => {
  const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
      user: emailUser,
      pass: emailPass,
    },
  });

  await transporter.sendMail({
    from: `"Media Scope" <${emailUser}>`,
    to,
    subject: 'Reset Password',
    html: `
      <p>Hai,</p>
      <p>Kami menerima permintaan untuk reset password akun kamu.</p>
      <p>Silakan klik link di bawah ini untuk reset password:</p>
      <a href="${resetLink}">${resetLink}</a>
      <p>Link ini berlaku selama 1 jam.</p>
    `,
  });
};

module.exports = { sendResetEmail };
