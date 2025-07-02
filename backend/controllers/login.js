import express from 'express';
import { PrismaClient } from '@prisma/client';
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';

const router = express.Router();
const prisma = new PrismaClient();

const JWT_SECRET = "chave270";

router.post('/login', async (req, res) => {
  const { email, senha } = req.body;
// verifica se os campos n tao vazios
  if (!email || !senha) {
    return res.status(400).json({ erro: 'prencha todos os campos pfv' });
  }

  try {
    //tenta achar o usuario
    const usuario = await prisma.usuario.findUnique({ where: { email } });

    //verifica se o usuario existe
    if (!usuario) {
      return res.status(404).json({ erro: 'usuario não encontrado' });
    }

    //verifica se a senha ta correta
    const senhaCorreta = await bcrypt.compare(senha, usuario.senha);
    if (!senhaCorreta) {
      return res.status(401).json({ erro: 'senha incorreta' });
    }

    // faz o token
    const token = jwt.sign(
      { id: usuario.id, email: usuario.email },
      JWT_SECRET,
      { expiresIn: '1h' }
    );

    // faz o login
    res.status(200).json({
      mensagem: 'login realizadooooo uuuuuu',
      token,
      usuario: {
        id: usuario.id,
        nome: usuario.name,
        email: usuario.email,
        telefone: usuario.telefone,
      }
    });

  } catch (err) {
    //aaaaaaaa deu erro 
    console.error('affs deu erro no login', err);
    res.status(500).json({ erro: 'affs deu erro no login' });

  }
});

export default router;
