const cds = require("@sap/cds");
const { employees } = cds.entities("rounak.db.master");
const mysrvdemo = function(srv){
    srv.on('myFunction', (req,res) => {
        return "Hello" + req.data.msg;
    });

    srv.on("READ","ReadEmployeeSrv" , async(req,res) => {
        var results = [];

        // results.push({
        //     "ID": "02BD2137-0890-1EEA-A6C2-BB55C197E7FB",
        //     "nameFirst": "Christano",
        //     "nameMiddle": "Ronaldo",
        // });

        // CDS Query Language - Select * from DB
        // results = await cds.tx(req).run(SELECT.from(employees).limit(3));
        // CDS Query Language - Select record with where condition
        // results = await cds.tx(req).run(SELECT.from(employees).where({"nameFirst":"Franco"}));
        
        // CDS Query Language - where user pass key like /Entity/Key
        var whereCondition = req.data;
        console.log(whereCondition);

        if(whereCondition.hasOwnProperty("ID")){
            results = await cds.tx(req).run(SELECT.from(employees).where(whereCondition));
        }else{
            results = await cds.tx(req).run(SELECT.from(employees).limit(1));
        }

        return results;
    });
    // CDS Query Language - Create Service
    srv.on("CREATE","InsertEmployeeSrv", async(req,res) => {

        let returnData = cds.transaction(req).run([

            INSERT.into(employees).entries([req.data])

        ]).then((resolve,reject) => {
            if(typeof(resolve) !== undefined){
                return req.data;
            }else{
                req.error(500,"There was an issue in insert");
            }
        }).catch(err =>{
            req.error(500,"There was an error" +err);
        })

    });
    // Update Servcice
    srv.on("UPDATE","UpdateEmployeeSrv",async(req,res) => {

        let returnData = await cds.tx(req).run([

            UPDATE(employees).set({
                nameFirst : req.data.nameFirst
            }).where({ ID : req.data.ID}),

            UPDATE(employees).set({
                nameLast : req.data.nameLast
            }).where({ ID : req.data.ID})

        ]).then((resolve,reject)=>{
            if(typeof(resolve) !== undefined){
                return req.data;
            }else{
                req.error(500,"There was an issue in insert");
            }
        }).catch(err =>{
            req.error(500,"There was an error" +err);
        })

    });
        // Delete Servcice
        srv.on("DELETE","DeleteEmployeeSrv",async(req,res) => {

            let returnData = await cds.tx(req).run([
    
                DELETE.from(employees).where(req.data)
    
            ]).then((resolve,reject)=>{
                if(typeof(resolve) !== undefined){
                    return req.data;
                }else{
                    req.error(500,"There was an issue in insert");
                }
            }).catch(err =>{
                req.error(500,"There was an error" +err);
            })
    
        })


}

module.exports = mysrvdemo;