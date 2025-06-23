import { get, set, ref } from "firebase/database";
import { db } from "./db.js";

async function write(index, data) {
  if (!index || !data) throw Error("dado inexistente ou não válido");
  const dbRef = ref(db, index);
  await set(dbRef, data);
}

async function read(index) {
  if (!index) throw Error("dado inexistente ou não válido");
  const dbRef = ref(db, index);
  const snapshot = await get(dbRef);
  if (snapshot.exists()) {
    return snapshot.val();
  }
  return null;
}

export const database = {
  write,
  read
};
