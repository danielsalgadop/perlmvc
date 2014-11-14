console.log("js.js IS WORKING");
function prueba(){
	// alert("prueba en js.js IS WORKING2");
	console.log("prueba en js.js IS WORKING2");
}

// existe ESTA funcion embebido en perl en miHtml.pm::errores2DivErrores
// habria que unificarlas
function string2DivErrors(error){
	var x=document.getElementById("errores");
	x.innerHTML=error;
}
function removeDivErrors(){
	var x=document.getElementById("errores");
	x.innerHTML="";
}

// para contar
function check_length_textarea(my_form)
	{
		maxLen = 50; // max number of characters allowed
		if (my_form.my_text.value.length >= maxLen) {
			string2DivErrors("maximum limit is reached.");

		 }
		else{ // Maximum length not reached so update the value of my_text counter
			removeDivErrors();
			my_form.text_num.value = maxLen - my_form.my_text.value.length;}
	}