console.log("js.js IS WORKING");
function prueba(){
	// alert("prueba en js.js IS WORKING2");
	console.log("prueba en js.js IS WORKING2");
}
// function pruebaJquery(){
	// $( document ).ready(function() {
		// console.log( "jquery WORKING!" );
	// });
// }

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


// SMS 
// para contar number of letters of a given text_area
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
// el valor de templates_sms (ahora se carga desde templates_sms.json)
var templates_sms_borrar = {
	1:"1111 sasljfs XXX ldkfaj YYY ldkfajs ",
	2:"222sasljfs ldkfaj ldkfajs ",
	3:"333 sasljfs ldkfaj ldkfajs ",
	debug:"LARGO LARGO LARGO LARGO LARGO LARGO LARGO LARGO LARGO LARGO LARGO LARGO asdf3 sasljfs ldkfaj ldkfajs ",

};
$(document).ready(function(){
	// TODO detectar si ha hecho keydown (ha cambiado template).
	// var done_keydown = 0

	// Detectar que han seleccionado alguna template
       $("#template_select").change(function(){
       		var cargar_este_template = $("#template_select").val();
       		$("#textarea").val(templates_sms[cargar_este_template]);
       		check_length_textarea(my_form);

       });
});