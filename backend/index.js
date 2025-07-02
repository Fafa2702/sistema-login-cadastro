import express from 'express';
import { database } from './database/func.js';
import { db } from './database/db.js';
import { ref, get } from 'firebase/database';
import cadastroRoutes from './controllers/cadastro.js';
import loginRoutes from './controllers/login.js';
import cors from 'cors';


const app = express();
const PORT = 3000;
app.use(cors());

app.use(express.json());
app.use('/usuario', cadastroRoutes);
app.use('/usuario', loginRoutes);


app.listen(PORT, () => {
  console.log(`Servidor rodando em http://172.30.0.120:${PORT}`);
});


