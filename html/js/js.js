// console.log("js.js IS WORKING");
function prueba(){
	// alert("prueba en js.js IS WORKING2");
	// console.log("prueba en js.js IS WORKING2");
}

// habria que unificarlas
function string2DivErrors(error){
	var x=document.getElementById("errores");
	x.innerHTML=error;
}
function removeDivErrors(){
	var x=document.getElementById("errores");
	x.innerHTML="";
}



$(document).ready(function(){
	// launch datatables using class selector (instead of id selector) is better if you want to have more than 1 datatable in a page
	$('.table_for_datatable').DataTable();
});