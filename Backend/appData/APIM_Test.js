let getData = async (req, res) =>{
    try {
        console.log("Coverage.....")
        res.status(200).json({success: true});
    } catch (error) {
        console.error("Error retrieving retailing data:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
}

module.exports = {
    getData
}
