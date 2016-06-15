program randomUsernamesv2;
uses crt, sysutils;
const
abc = 'abcdefghijklmnopqrstuvwxyz';
type
arrNum = Array [1..7] of integer;
arrChar = Array [1..7] of char;
var
cantidad: char;
intCantidad,i,x,j,longitud,y: integer;
numeros: arrNum;
username,usernames: string;
strNumeros,strx: string;
letras: string;
archivo: text;
ruta: string;
begin
randomize;
//cantidad:= readkey;
readln(intCantidad);
//val(cantidad,intCantidad);
longitud:=7;
usernames:='';
ruta:= GetcurrentDir + '\usernames.txt';
Assign(archivo,ruta);
//Rewrite(archivo);
//close(archivo);
//writeln('current dir', GetCurrentDir);
for i:=1 to intCantidad do
begin
     strNumeros:='';
     letras:='';
     username:='1234567';

     for j:=1 to longitud do
     begin
          numeros[j]:= random(9) +1;
          str(numeros[j],strx);
          strNumeros:=strNumeros + strx;
     end;

     for j:=1 to longitud do
     begin
          x:= random(26)+1;
          Letras:=Letras + abc[x];
     end;


     for j:=1 to longitud do
     begin
          y:= random(2)+1;
          if (y=1) then
          begin
               x:= random(longitud)+1;
               username[j]:= letras[x];
          end
          else
              begin
              x:= random(longitud)+1;
              username[j]:= strNumeros[x];
              end;
     end;



    // writeln(strnumeros);
    // writeln(letras);
     while (Pos(username,usernames)<>0) do
     begin
          for j:=1 to longitud do
          begin
               numeros[j]:= random(9) +1;
               str(numeros[j],strx);
               strNumeros:=strNumeros + strx;
          end;

          for j:=1 to longitud do
          begin
               x:= random(27)+1;
               Letras:=Letras + abc[x];
          end;

          for j:=1 to longitud do
          begin
               y:= random(2)+1;

               if (y=1) then
               begin
                    x:= random(longitud)+1;
                    username:= username + letras[x];
               end
               else
               begin
                    x:= random(longitud)+1;
                    username:= username+ strNumeros[x];
               end;
          end;
     end;

     usernames:= usernames + username + '/';

     Append(archivo);
     writeln(archivo,username);
     close(archivo);

     //writeln(y);
     //readln;
end;
  //writeln(usernames);
 //readln;
end.
