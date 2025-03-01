const User = require("../models/User.js")
const bcrypt = require("bcryptjs")
const jwt = require("jsonwebtoken")

exports.register = async(req,res) => {
    try{
        const {name,email,password,phone,bloodType,address,isDoner} = req.body;
        const user = new User({name,email,password,phone,bloodType,address,isDoner});
        await user.save();
        res.status(201).json({message: "User registered Successfully"});
    }catch(error){
        res.status(500).json({error: error.message});
    }
}

exports.login = async (req, res) => {
    try {
        const { email, password } = req.body;
        const user = await User.findOne({ email });
        if (!user) return res.status(404).json({ message: "User not found" });

        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) return res.status(400).json({ message: "Invalid credentials" });

        const token = jwt.sign({ userId: user._id }, process.env.JWT_SECRET, { expiresIn: "7d" });
        res.status(200).json({ token, user });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.getDonors = async (req, res) => {
    try {
        const donors = await User.find({ isDonor: true, isActive: true }).select("-password");
        res.status(200).json(donors);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};