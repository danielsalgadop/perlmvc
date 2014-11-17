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

# --- Lee una linea de archivo JSON. --- #
sub LeeJson($){
  
  my $archivo=shift;
  # --- DATOS GENERICOS. --- #
  open(CONFIG,"$archivo");
    my @Config=<CONFIG>;
  close(CONFIG);
  
  my $jsoncfg= new JSON;
  my $enperlcfg = $jsoncfg->decode($Config[0]);
  my %Hcfg = %$enperlcfg;
  return(%Hcfg);
}#Cierra sub LeeJson($)

# --- Decodifica JSON. --- #
# bad formated json should be detected
sub DecodificaJson($){

  my $dato=shift;

  my $json= new JSON;
  my $enperl = $json->decode($dato);
  my %Hash = %$enperl;

  return(%Hash);

}#Cierra sub DecodificaJson($)

# --- Codifica JSON. --- #
sub CodificaJson($){

  # --- Recibe una referencia a un hash. --- #
  my $dato=shift;

  my $json=new JSON;
  my $informacion=$json->encode($dato);

  return($informacion);

}#Cierra sub CodificaJson($)


# Function: FileJSON2Hash  (OJO NO espera agregacion de jsons, sino un unico json EN UNA UNICA LINEA) Es parece mucho a DecodificaJson
# Receives a path to file. These file must be unique jsons
# Returns a hash{status}
# Returns a hash{hash} = Content of file (json) as hash
# TODO,bad formated json should be detected by DecodificaJson
sub fileJSON2Hash($){
  my $path_to_file = shift;
  my %return;
  $return{status} = "OK";
  my %hash_with_json;

  open (FILEJSON, $path_to_file);
  my @file = <FILEJSON>;
  close FILEJSON;
  chomp(@file);

  my %hash_unalinea = DecodificaJson($file[0]);  # es una sola linea, por eso $file[0]
  $return{hash}= \%hash_unalinea;
  # my %hash = (
    # ref=>\%return{hash},
    # titulo=>"fileJSON2Hash para $path_to_file",
  # );
  # print2File(\%hash);

  return(%return);

}


1;