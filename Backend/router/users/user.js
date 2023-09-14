const express = require('express')
const router = express.Router();

const user = require('../../Auth/userAuth')

// ======================== Home Page ========================//
router.get('/users/userLogin', user.loginUser);
router.get('/users/verify', user.userProfile);
// router.get('/users/verifyToken', auth.isAuthenticated);

module.exports = router;
