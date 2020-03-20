const KoaRouter = require('koa-router');
const Schema = require('validate');
const crypto = require('crypto');
const axios = require('axios').default;
const { RECAPTCHA_SECRET } = require('../config');
const qs = require('querystring');

const users = new KoaRouter({
    prefix: '/users'
});

const createUserRequest = new Schema({
    username: {
        type: String,
        required: true,
        length: { min: 4, max: 16 },
        match: /^[a-zA-Z0-9_-]{4,16}$/
    },
    password: {
        type: String,
        required: true,
        length: { min: 6, max: 16 }
    },
    reCaptchaKey: {
        type: String,
        required: true,
    }
});

users.post('/', async ctx => {
    const errors = createUserRequest.validate(ctx.request.body);
    if (errors.length > 0) {
        ctx.throw(400, 'ValidationFailed', errors);
    }

    const username = ctx.request.body.username.toUpperCase();
    const password = ctx.request.body.password.toUpperCase();
    console.log(RECAPTCHA_SECRET)
    const catpchaReqBody = {
        secret: RECAPTCHA_SECRET,
        response: ctx.request.body.reCaptchaKey
    }
    const catpchaReqBodyCfg = {
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        }
    }

    const resp = await axios.post('https://www.google.com/recaptcha/api/siteverify', qs.stringify(catpchaReqBody), catpchaReqBodyCfg);

    if (!resp.data.success) {
        ctx.response.body = { type: 'InvalidCaptchaCode' }
        return;
    }

    const [checkUsernameExistResults] = await ctx.db.auth.query(`
        SELECT username from account where username = ?
    `, [
        ctx.request.body.username
    ]);

    if (checkUsernameExistResults.length > 0) {
        ctx.response.body = { type: 'UsernameTaken' };
        return;
    }

    const hash = crypto.createHash('sha1');

    hash.update(username, 'utf8');
    hash.update(':', 'utf8');
    hash.update(password, 'utf8');

    const shaPassHash = hash.digest('hex');

    const [createUserQueryResult] = await ctx.db.auth.query(`
        insert into account(username, sha_pass_hash, joindate) values( ?, ?, NOW())
    `, [username, shaPassHash]);

    ctx.response.body = { type: 'Ok', id: createUserQueryResult.insertId };

});

module.exports = { users }