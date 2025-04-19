

// Registro E Login
var Usuario_Nome = "";
var Usuario_CPF_CNPJ = "";
var Usuario_Email = "";
var Usuario_Senha = "";

function Verify_Variables(){

    var email = input_email.value
    if(/@/.test(email)){
        Usuario_Email = email
        div_email_verify.innerHTML = "";

    }
    else{
        div_email_verify.innerHTML = "*"
    }


/*
    if(
        Usuario_Nome == ""||
        Usuario_Email == "" ||
        Usuario_CPF_CNPJ == ""
    ){
        div_Login_Alert.innerHTML = "Preencha Todos Os Campos!"
    }

    if(Usuario_Nome == ""){
        span_nome.innerHTML = `<p class="verify-text">Nome:</p>`
    }else{
        span_nome.innerHTML = "Nome:"
    }
    if(Usuario_Email == ""){
        span_email.innerHTML = `<p class="verify-text">Email:</p>`
    }else{
        Verify_Email()
        span_email.innerHTML = "E-mail:"
    }
    if(Usuario_CPF_CNPJ == ""){
        span_cpf_cnpj.innerHTML = `<p class="verify-text">CPF ou CNPJ:</p>`
    }else{
        span_cpf_cnpj.innerHTML = "CPF ou CNPJ:"
    }

    if(
        Usuario_Nome != ""||
        Usuario_Email != "" ||
        Usuario_CPF_CNPJ != ""
    ){

    }

*/
}


