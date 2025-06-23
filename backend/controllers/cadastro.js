import express from 'express';
import { PrismaClient } from '@prisma/client';

const router = express.Router();
const prisma = new PrismaClient();

// get 
router.get('/', async (req, res) => {
  try {
    const filtro = req.query.name;
    const usuarios = filtro
      ? await prisma.usuario.findMany({
          where: {
            OR: [
              { name: filtro },
              { email: filtro },
              { telefone: filtro }
            ]
          }
        })
      : await prisma.usuario.findMany();

    res.json(usuarios);
  } catch (err) {
    console.error(err);
    res.status(500).json({ erro: 'Erro ao buscar usuário' });
  }
});

// post
router.post('/', async (req, res) => {
  try {
    const { name, email, telefone, senha } = req.body;
    const novo = await prisma.usuario.create({
      data: { name, email, telefone, senha }
    });
    res.status(201).json(novo);
  } catch (err) {
    console.error(err);
    res.status(500).json({ erro: 'Erro ao criar usuário' });
  }
});

// put
router.put('/:id', async (req, res) => {
  try {
    const atualizado = await prisma.usuario.update({
      where: { id: Number(req.params.id) },
      data: req.body
    });
    res.json(atualizado);
  } catch (err) {
    console.error(err);
    res.status(500).json({ erro: 'Erro ao atualizar usuário' });
  }
});

// deleta
router.delete('/:id', async (req, res) => {
  try {
    const id = Number(req.params.id);
    await prisma.usuario.delete({ where: { id } });
    res.json({ message: 'Deletado com sucesso' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ erro: 'Erro ao deletar usuário' });
  }
});

export default router;
