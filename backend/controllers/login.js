import express from 'express';
import { PrismaClient } from '@prisma/client';
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';

const router = express.Router();
const prisma = new PrismaClient();

const JWT_SECRET = "chave270";

router.post('/login', async (req, res) =>{





    
})



export default router;
