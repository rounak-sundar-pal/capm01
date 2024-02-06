const { parse } = require("@sap/cds");

module.exports = cds.service.impl(async function(){

    const {
        Employee
    } = this.entities;

    this.before('UPDATE',Employee, (req,res)=> {
        if(parseFloat(req.data.salaryAmount) >= 100000){
            req.error(500,"Salary nust be below 100000");
        }
    });

})