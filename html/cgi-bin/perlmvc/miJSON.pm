#!/usr/bin/perl -w

use strict;
use JSON;

# -------------------------------------------------------------------------------------------------------
#  Nombre: miJSON.pm                               Version: 1.0
# -------------------------------------------------------------------------------------------------------
# funciones comunes hechas con JSON

my $debug=0;

#   Function: BuscarEnArrayJson

#       Recibe un ref@Array que es el resultado de @Array = <FICH>. siendo el FICH jsones linea por linea
#       Recibe un ref%patrones
#       Devuelve numero de lineas que tienen TODOS los parametros en una misma linea
#       Si hay error $return{status}="la descripcion del error"; sino $return{status}="OK";
#       Sustituye al anterior &BuscarenArray
# TODO mete el modo (#      Recibe: MODO (l- numero de veces que aparece el patron), (i- devuelve ref_array con Array sin las lineas))
sub BuscarEnArrayJson($$)
{
    my $refArray = shift;          # array de jsones concatenados
    my $refHash  = shift;          # hash con key => values que devemos encontrar
    my @Array    = @{$refArray};
    my %patrones = %{$refHash};
    my %return;
    $return{status} = "OK";
    # NO han llegado los Argumentos necesarios
    if (!@Array or !%patrones) {
        $return{status} =
            "ERROR en ["
          . (caller(0))[3]
          . "] Falta de Argumentos";    # con (caller(0))[3] saco el nombre de la subrutina
        return (%return);
    }
    ### variables locales
    my $json = new JSON;

    my @lineasSINpatron;
    my @lineasCONpatron;

    # recorro el array de jsones
    foreach my $unalinea (@Array) {
        my $ref_hash_decoded = $json->decode($unalinea);
        my %decoded          = %{$ref_hash_decoded};
        my $tiene_todos =
          1;    # flag que determina si se han encontrado todos los  valores en la linea
        foreach my $keybuscada (keys(%patrones)) {
            unless ($decoded{$keybuscada} == $patrones{$keybuscada})
            { # con que exista un solo keybuscada que no este en decoded o que no coincida con el valor, no nos vale
                $tiene_todos = 0;
                last;
            }
        }
        if ($tiene_todos) {
            push(@lineasCONpatron, $unalinea);
        }
        else {
            push(@lineasSINpatron, $unalinea);
        }
    }

    $return{array_jsones_lineas_con_patron} = \@lineasCONpatron;
    $return{array_jsones_lineas_sin_patron} = \@lineasSINpatron;
    $return{num_lineas_con_patron}          = @lineasCONpatron;
    $return{num_lineas_sin_patron}          = @lineasSINpatron;
    return (%return);
}

# Recibe un json y lo concatena a un file
#
#
sub ConcatJson2File($$)
{
    my $json = shift;
    my $file = shift;
    my %return;
    $return{status} = "OK";
    $return{value}  = "";
    if ($json =~ /\{\s*\}/ or !$file) {
        $return{status} = "ConcatJson2File, no ha recibido los 2 argumentos necesarios";
        $return{status} .= " FALTA Json " if $json =~ /\{\s*\}/;
        $return{status} .= " FALTA File " unless $file;
    }
    else {
            # json y file recibidios por funcion
            print "json=[".$json."] file=[".$file."]<br>" if $debug;
        if (open(FILE, ">> " . $file)) {
            print FILE $json . "\n";
            close(FILE);
        }
        else {
            $return{status} = "no he podido abrir fichero =["
              . $file . "]";
        }
    }
    return (%return);
}


# --- Decodifica JSON. --- #
# Receives: a string with json (literal json)
# bad formated json DETECTED
sub DecodificaJson($){

  # my $dato=shift;

  my $json= new JSON;
  my $ref_perlhash;

  eval {
      $ref_perlhash = $json->decode(shift);
  };
  if($@){     # PROBLEMS
    chomp($@);
    return(status=>"ERROR",message=>"error [1d1] ".$@);
  }
  # my $enperl = $json->decode($dato);
  # my %Hash = %$enperl;

  return(status=>"OK",ref_json_hash=>$ref_perlhash);

}#Cierra sub DecodificaJson($)

# --- Codifica JSON. --- #
sub CodificaJson($;$){

  # --- Recibe una referencia a un hash. --- #
  my $dato=shift;
  my $avoid_pretty_print  = shift;
  my $caller;
  # $caller .= "[data Received ".Dumper(%{$dato})."] [CALLER -".(caller(1))[3]."] "; # who called this subroutine
  $caller .= "[data Received ".$dato."] [CALLER -".(caller(1))[3]."] "; # who called this subroutine

  return(status=>"ERROR",message=>$caller."[ERROR-pl1cj] empty json") if (!$dato or $dato=~/^\s*$/);
  my $json=new JSON;
  my $en_json;
  eval {
    if($avoid_pretty_print){
    $en_json=$json->encode($dato);
    }
    else{
      $en_json=$json->pretty->encode($dato);
    }
  };
  if($@){
    chomp($@);
    return(status=>"ERROR",message=>$caller."[ERROR-cj2] [PERL EVAL ERROR -".$@."]");
  }

  return(status=>"OK",json=>$en_json);

}#Cierra sub CodificaJson($)


# Function universalJsonReader
#
# Receives:
# $path_al_json
#
# Returns:
#   hash{status} = ERROR and hash{message} = descritption of failure
# or 
#   returns form fileJSON2Hash and fileJSON2Hash
#
# What does it do?
# Comprueba que $path_al_json existe y que es leible
# lanza fileJSON2Hash and fileJSON2HashAgregado
sub universalJsonReader($){
  my $path_al_json = shift;

  # file must exist
  return(status=>"ERROR",message=>"File $path_al_json must exist") unless (-e $path_al_json);
  # file must have read permissions
  return(status=>"ERROR",message=>"File $path_al_json must be readable") unless (-r $path_al_json);

  # executes fileJSON2Hash if !OK executes fileJSON2HashAgregado
  my %return =  fileJSON2Hash($path_al_json);
  return %return if $return{status} eq "OK";   # OJO you never get the return form ERROR in fileJSON2Hash
  fileJSON2HashAgregado($path_al_json);
}

# --- Lee una linea de archivo JSON. --- #
# Receives: path to file
# For coherence with universalJsonReader and use inside universalJsonReader it will always return hash{1}=
# BE AWARE -  if a json has repeated keys it will construct only 1 of them! you will loose the information of the other
sub fileJSON2Hash($){

  # my $archivo=shift;
  my $file_in_string;
  # --- DATOS GENERICOS. --- #
  {
    # We change $/ all file into a uniq string, so we can charge files
    # simple {"key":"value"}
    # and
    # extended
    # {
    #  "key":"value"
    # }
    local $/=undef;
    open(FILE,shift);
    $file_in_string = <FILE>;
    close FILE;
}

  my $jsoncfg = new JSON;
  my $ref_perlhash;
  eval {
      $ref_perlhash = $jsoncfg->decode($file_in_string);
  };
  if($@){     # PROBLEMS
        chomp($@);
        return(status=>"ERROR",message=>"error [3ew] ".$@);
  }
  my %hash_json;
  $hash_json{1} = $ref_perlhash;   # line number 1, hardcoded
  return(status=>"OK",ref_json_hash=>\%hash_json);
}#Cierra sub universalJsonReader($)

# Function: fileJSON2HashAgregado similar to FileJSON2Hash but the origin file is an agregation of jsons
# Receives a path to file. These file must be an agregation of jsons
# Returns a %return{status} = (OK|ERROR|WARNING)
#     OK      - all json are OK
#       %return{ref_json_hash} = ref to a hash
#     ERRROR  - none jsons are OK.
#       %return{ref_json_hash_errors} = a ref to an array
#     WARNING - some lines are OK, some are ERRORS
#       %return{ref_json_hash} = ref to a hash
#       %return{ref_json_hash_errors} = a ref to an array
#
# Returns a return{hash} = Content of file (json) as hash. The keys are the number of line of the origin file
sub fileJSON2HashAgregado($){
  my $path_to_file = shift;
  my %hash_with_jsons;

  open (FILEJSON, $path_to_file);
  my @file = <FILEJSON>;
  close FILEJSON;

  my $cont = 0;
  my %hash_with_badly_formated_lines;
  foreach my $unalinea(@file){
    # print "\$unalinea".$unalinea."<br>";
    $cont++;
    my %r_DecodificaJson = DecodificaJson($unalinea);

    if ($r_DecodificaJson{status} eq "OK"){
      $hash_with_jsons{$cont} = $r_DecodificaJson{ref_json_hash};
  }
    else{ # Bad formatted in a line
      $hash_with_badly_formated_lines{$cont} = "BADLY formated json error [".$r_DecodificaJson{message}."]";
    }
  }
  # construct %return
  my %return;
  if(scalar keys %hash_with_badly_formated_lines == 0){ # OK
    $return{status} = "OK";
    $return{ref_json_hash}= \%hash_with_jsons;
  }
  elsif(scalar keys %hash_with_jsons == 0){ # ERROR
    $return{status} = "ERROR";
    $return{ref_json_hash_errors} = \%hash_with_badly_formated_lines;
  }
  else{
    $return{status} = "WARNING";
    $return{ref_json_hash_errors} = \%hash_with_badly_formated_lines;
    $return{ref_json_hash}= \%hash_with_jsons;

  }
  return(%return);

}

# Function: stringifyHash
# Receives:
#     - (ref_hash): with a (complex) hash. hash{num_linea} = DATA
# Returns:
#     -hash{status} = OK|ERROR
#           - OK.  hash{string} =  (string): with every DATA converted to json in the order determined by {num_linea}
#           - ERROR. hash{message}
# Description:
# ir is used to write modifications in %fichero_cambios_etc_hosts, previosuly to be written in $path_absoluto_cambios_etc_host
sub stringifyHash($){
  my $ref_hash_to_be_strinfified  = shift;
  my %hash_to_be_strinfified      = %{$ref_hash_to_be_strinfified};
  my $string;

  foreach my $num_linea(sort {$a <=> $b} keys %hash_to_be_strinfified){
    my %r_CodificaJson = CodificaJson(\%{$hash_to_be_strinfified{$num_linea}});
    if($r_CodificaJson{status} eq "ERROR"){  # este error seria rarisimo, ya que si la linea no fuese un json se habria quejado antes, lo dejo just in case
      return({status=>"ERROR",message=>"[ERROR-pl1sH] POR FAVOR, REPORTA ESTA INCIDENCIA, Gracias ".$r_CodificaJson{message}});
    }
    $string .= $r_CodificaJson{json};
    $string .= "\n";
  }
  return(status=>"OK",string=>$string);
}
1;