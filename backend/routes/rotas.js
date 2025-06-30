import express from 'express';
import cadastroController from '../controllers/cadastro.js';
import loginController from '../controllers/login.js';

const router = express.Router();

router.use(cadastroController); // cadastro
router.use(loginController);    // login

export default router;
