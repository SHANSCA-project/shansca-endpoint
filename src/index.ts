#!/usr/bin/env node

import express from 'express'
import cors from 'cors'

const app = express()
app.use(cors())

app.get('/', (req, res) => {
    res.json(new Date().toISOString())
})

app.listen(3000, () => {
    console.log("Listening for connections...")
})