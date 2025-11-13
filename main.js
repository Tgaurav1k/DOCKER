const express = require("express")
const app = express();

const PORT = process.env.PORT || 8000;

app.get("/", (req,res)=>{
    return res.json({message:"hey , i am nodeJS in container v5"});
});

app.listen(PORT, ()=> console.log(`Server started on PORT : ${PORT} `))

