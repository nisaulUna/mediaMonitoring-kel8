// activityLogger.js
const { db } = require('./config');

// Konstanta action type
const ACTION_TYPES = {
    LOGIN: 'login',
    LOGOUT: 'logout',
    REGISTER: 'register',
    UPDATE_PROFIL: 'update_profil',
    FAILED_LOGIN: 'failed_login'
};

// Helper log activity
async function logActivity(userId, actionType, req, extraData = {}) {
    try {
        const actionDetails = JSON.stringify({
            ip: req.ip,
            userAgent: req.headers['user-agent'],
            ...extraData
        });

        await db.query(
            'INSERT INTO log_activities (id_user, action_type, action_details) VALUES (?, ?, ?)',
            [userId, actionType, actionDetails]
        );
    } catch (err) {
        console.error('Failed to log activity:', err);
    }
}

module.exports = { logActivity, ACTION_TYPES };
