const express = require("express");
const dotenv = require("dotenv");
const cors = require("cors");
const connectDB = require("./config/db.js");
const userRoutes = require("./routes/userRoutes.js");
const donorRoutes = require("./routes/donorRoutes.js");
const bloodRequestRoutes = require("./routes/bloodRequestRoutes.js");
const donationRoutes = require("./routes/donationRoutes.js");
const sosRoutes = require("./routes/sosRoutes.js");
const bloodBankRoutes = require("./routes/bloodBankRoutes.js");
const notificationRoutes = require("./routes/notificationRoutes.js");
const chatRoutes = require("./routes/chatRoutes.js");

dotenv.config();
connectDB();
const app = express();

app.use(cors());
app.use(express.json());

// Routes
app.use("/api/users", userRoutes);
app.use("/api/donors", donorRoutes);
app.use("/api/blood-requests", bloodRequestRoutes);
app.use("/api/donations", donationRoutes);
app.use("/api/sos", sosRoutes);
app.use("/api/blood-banks", bloodBankRoutes);
app.use("/api/notifications", notificationRoutes);
app.use("/api/chat", chatRoutes);



const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
