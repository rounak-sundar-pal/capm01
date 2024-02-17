const { parse, update } = require("@sap/cds");

module.exports = cds.service.impl(async function () {
  const { Employee, POs } = this.entities;

  this.before("UPDATE", Employee, (req, res) => {
    if (parseFloat(req.data.salaryAmount) >= 100000) {
      req.error(500, "Salary nust be below 100000");
    }
  });

  this.on("boost", async (req) => {
    try {
          const ID = req.params[0];
          console.log("Your Purchase Order Number " + ID + " will be boosted");
          const tx = cds.tx(req);
          await tx.UPDATE(POs).with({
              GROSS_AMOUNT : {'+=':2000},
              NOTE:"Boosted!!"
          }).where(ID);

          return POs;

    } catch (error) {
      return "Error" + error.toString();
    }
  });

  this.on("largestOrder", async (req) => {
    try {
      const ID = req.params[0];
      console.log("Your Purchase Order Number " + ID + "will be boosted");
      const tx = cds.tx(req);
      const reply = await tx
        .read(POs)
        .orderby({
          GROSS_AMOUNT: "desc",
        })
        .limit(1);
      return reply;
    } catch (error) {
      return "Error" + error.toString();
    }
  });
});
