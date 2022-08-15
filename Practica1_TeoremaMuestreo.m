%Generar e imprimir la señal
figure(1) %La primera imagen dedicada a la señal continua
Fs = 1000; %frecuencia de muestreo para graficar la señal continua
duracion = 1; %duracion en segundos de nuestra funcion
[x_1,t_1] = generateSignal(Fs,duracion); %llama a la funcion que crea los valores de "x" y "t" los cuales se guardan en "x_1" y "t_1"
plot(t_1, x_1), xlabel('tiempo (Seg)'), ylabel('amplitud'), title('Señal a Analizar') %Grafica la señal

figure(2) %La segunda imagen esta dedicada a las señales muestreadas
%Se realizan los mismos pasos que con la anterior señal, ahora la forma de graficar difiere
Fs = 10; %Primera propuesta de frecuencia de muestreo en Hz
duracion = 1; 
[mx_1,mt_1] = generateSignal(Fs,duracion); 
nexttile
stem(mt_1, mx_1), xlabel('muestras'), ylabel('magnitud'), title('Señal muestreada a 10Hz') %Para apreciar el muestreo se usa la funcion stem en lugar de plot
t1_sinc = t_1;
x1_sinc = reconstruir_sinc(mx_1, mt_1, t1_sinc); %Utilizamos la funcion "reconstruir_sinc" declarada hasta abajo

figure(3) %La figura tres esta dedicada a las graficas reconstruidas por la interpolacion de shannon
nexttile %comando para agregar varios plots en una sola imagen
plot(t1_sinc, x1_sinc), xlabel('tiempo (Seg)'), ylabel('amplitud'), title('Reconstruccion 10Hz')


figure(2) %A la fig 2 se le añade otra grafica 
Fs = 25; %Ahora la frecuancia propuesta es de 25Hz
duracion = 1;
[mx_2,mt_2] = generateSignal(Fs,duracion);
nexttile
stem(mt_1, mx_1), xlabel('muestras'), ylabel('magnitud'), title('Señal muestreada a 25Hz')
t2_sinc = mt_2;
x2_sinc = reconstruir_sinc(mx_2, mt_2, t2_sinc);

figure(3) %A la fig 3 se le añade otra grafica de la señal reconstruida
nexttile
plot(t2_sinc, x2_sinc), xlabel('tiempo (Seg)'), ylabel('amplitud'), title('Reconstruccion 25Hz')


figure(2) %Mismo procedimiento ahora para una frecunacia de muestreo mayor del doble de nuestra frecuencia maxima. Siguiendo el teorema de Nyquist
Fs = 90;
duracion = 1;
[mx_3,mt_3] = generateSignal(Fs,duracion);
nexttile
stem(mt_1, mx_1), xlabel('muestras'), ylabel('magnitud'), title('Señal muestreada a 90Hz')
t3_sinc = mt_3;
x3_sinc = reconstruir_sinc(mx_3, mt_3, t3_sinc);

figure(3)
nexttile
plot(t3_sinc, x3_sinc), xlabel('tiempo (Seg)'), ylabel('amplitud'), title('Reconstruccion 90Hz')

figure(5)
Fs = 600;
duracion = 1;
[mx_4,mt_4] = generateSignal(Fs,duracion);
nexttile
stem(mt_4, mx_4), xlabel('muestras'), ylabel('magnitud'), title('Señal muestreada a 600Hz')
t4_sinc = mt_4;
x4_sinc = reconstruir_sinc(mx_4, mt_4, t4_sinc);

figure(4)
nexttile
plot(t4_sinc, x4_sinc), xlabel('tiempo (Seg)'), ylabel('amplitud'), title('Reconstruccion 600Hz')

%funcniones 

function x_sinc = reconstruir_sinc(x, t, t_sinc) %Los parametros x, t, t_sinc son necesarios en el codigo. t_sinc debe ser igual al t de la señal continua
    Fs = 1/t(2); %Se obtiene la frecuancia de muestreo apartir del periodo de muestreo
    size_x = size(t_sinc,2); %Se obtiene la dimencion de nuestro arreglo
    x_sinc = zeros(1,size_x); %Se crea el arreglo donde se guardara la informacion
  for n = 1:length(t)
    x_sinc = x_sinc + x(n) * sinc(Fs * t_sinc - n); %Se realiza la convolucion a cada muestra
  end
end

function [x,t] = generateSignal(Fs, duracion) %funcion para generar la señal a Analizar
    N = duracion;
    step = 1/Fs;
    t = 0:step:N;
    x = sin(2*pi*3*(t-0.4))+0.5*sin(2*pi*9*(t-0.2))+0.1*sin(2*pi*30*t); %suma de senos
end

