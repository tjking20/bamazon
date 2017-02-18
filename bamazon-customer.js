var inquirer = require("inquirer");
var mysql = require("mysql");

var connection = mysql.createConnection({
	host: "localhost",
	user: "root",
	password: "root",
	database: "bamazon_db",
	port: 8889
});
// connection.connect();


// function lookUpPrice(id){
// 	connection.query("SELECT price FROM products WHERE id = " id)
// }

function runBamazonInterface(){
	connection.query("SELECT * FROM products", function(error, results, fields){
		//handles query errors
		if (error) throw error;

		//welcomes the user to bamazon and console logs items from the products table.
		console.log("Welcome to Bamazon!");
		console.log("----------------------------------------------------------------------------");
		for(var i = 0; i < results.length; i++){
			var product = results[i];
			console.log("Item: #" + product.id, product.product_name, "$" + product.price);		
		};
		console.log("----------------------------------------------------------------------------");
		//inquirer asks the user for the item id and quantity that they would like to purchase.
		inquirer.prompt([
		{
			type: "input",
			name: "id",
			message: "What is the id of item you would like to purchase"
		}, {
			type: "input",
			name: "quantity",
			message: "Quantity?"

		}
		]).then (function(data){
			var id = data.id
			connection.query("SELECT stock_quantity FROM products WHERE id = " + id, function(error, results, fields){
				if (error) throw error;
				var supply = results[0].stock_quantity;
				var demand = data.quantity
				var currentSupply = supply - demand

				if(currentSupply >= 0){
					console.log("processing order...");
					connection.query("SELECT price FROM products WHERE id = " + id, function(error, results, fields){
						var price = results[0].price;
						var total = price * demand

						inquirer.prompt([
							{
								type:"input",
								name: "purchase",
								message: " Your total is: $" + total + 
								". Type 'B' to buy items, or 'Q' to return to main menu"
							}
						]).then(function(data){
							if (data.purchase == "B"){
								console.log("Thank uo for your purchase!")
								connection.query("UPDATE products SET ? WHERE ? ", 
									[{
										stock_quantity: currentSupply
									},{
										id: id

									}], function (error, results, fields){
										// console.log(results);
										
									});
								connection.query("INSERT INTO sales (product_id, quantity_purchased)" + 
								"VALUES (" + id +"," + demand +")",
								function(error, results, fields){
										runBamazonInterface();
								});

							} else{
								runBamazonInterface();
							}

						});
					});
					
				} else{
					console.log("Insufficient Items! Please enter your order again");
					runBamazonInterface();
				};
			});
		});
	});	//end original connection.query
};// end selectFromTable function
runBamazonInterface();








