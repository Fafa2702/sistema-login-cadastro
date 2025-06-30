import express from 'express';
import { PrismaClient } from '@prisma/client';
import bcrypt from 'bcryptjs';
const prisma = new PrismaClient()
const PORT = 3000
const HOST = '172.30.0.131'

const router = express.Router();

// rota para ver
router.get('/', async (req, res) => {
  console.log("pagina caregada")
  try {
    let usuario = []
    // filtro query
 const filtro = req.query.name;

if (filtro) {
  usuario = await prisma.usuario.findMany({
    where: {
      OR: [
        { name: filtro },
        { email: filtro },
        { telefone: filtro }
      ]
    }
  });
} else {
  usuario = await prisma.usuario.findMany();
}

    res.json(usuario)
  } catch (err) {
    console.error(err)
    res.status(500).json({ erro: 'erro ao buscar o usuario' })
  }
})





// rota de cadastro
router.post('/', async (req, res) => {
  try {

 const { name, telefone, email, senha } = req.body;

    if (!name || !telefone || !email || !senha) {
      return res.status(400).json({ erro: 'Prencha todos os campos por favor' });
    }

    // cripitogração da senha 
    const saltRounds = 10;
    const senhaHashed = await bcrypt.hash(senha, saltRounds);
    console.log(hash)
    
    const novo = await prisma.usuario.create({
      data: {
        name,
        telefone,
        email,
        senha: senhaHashed
      }
    });

    res.status(201).json(novo);
  } catch (err) {
    console.error(err);
    res.status(500).json({ erro: 'erro ao criar usuario' });
  }
});






// ": significa variavel" -- edita
router.put('/:id', async (req, res) => {
  try {
    if (!req.body.name || !req.body.telefone || !req.body.email) {
  return res.status(400).json({ erro: "Campos obrigatórios não preenchidos" });
}
    const atualizado = await prisma.usuario.update({
      where: { id: Number(req.params.id) },
      data: {
        name: req.body.name,
        telefone: req.body.telefone,
        email: req.body.email
      }
    })
    res.status(200).json(atualizado)
  } catch (err) {
    console.error(err)
    res.status(500).json({ erro: 'erro ao atualizar usuario' })
  }
})







// deleta
router.delete('/:id', async (req, res) => {
  try {
    const id = Number(req.params.id);

    const existe = await prisma.usuario.findUnique({
      where: { id }
    });


    await prisma.usuario.delete({
      where: { id }
    });

    res.status(200).json({ message: 'deletado com sucesso' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ erro: 'erro ao deletar usuario' });
  }
});

export default router;
