
figure(1)
Fs = 1000;
duracion = 1;
[x_1,t_1] = generateSignal(Fs,duracion);
plot(t_1, x_1), xlabel('tiempo (Seg)'), ylabel('amplitud'), title('Señal a Analizar')

figure(2)
Fs = 10;
duracion = 1;
[mx_1,mt_1] = generateSignal(Fs,duracion);
nexttile
stem(mt_1, mx_1), xlabel('muestras'), ylabel('magnitud'), title('Señal muestreada a 10Hz')
t1_sinc = t_1;
x1_sinc = reconstruir_sinc(mx_1, mt_1, t1_sinc);

figure(3)
nexttile
plot(t1_sinc, x1_sinc), xlabel('tiempo (Seg)'), ylabel('amplitud'), title('Reconstruccion 10Hz')


figure(2)
Fs = 25;
duracion = 1;
[mx_2,mt_2] = generateSignal(Fs,duracion);
nexttile
stem(mt_1, mx_1), xlabel('muestras'), ylabel('magnitud'), title('Señal muestreada a 25Hz')
t2_sinc = mt_2;
x2_sinc = reconstruir_sinc(mx_2, mt_2, t2_sinc);

figure(3)
nexttile
plot(t2_sinc, x2_sinc), xlabel('tiempo (Seg)'), ylabel('amplitud'), title('Reconstruccion 25Hz')


figure(2)
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

function x_sinc = reconstruir_sinc(x, t, t_sinc)
    Fs = 1/t(2);
    size_x = size(t_sinc,2);
    x_sinc = zeros(1,size_x);
  for n = 1:length(t)
    x_sinc = x_sinc + x(n) * sinc(Fs * t_sinc - n);
  end
end

function [x,t] = generateSignal(Fs, duracion)
    N = duracion;
    step = 1/Fs;
    t = 0:step:N;
    x = sin(2*pi*3*(t-0.4))+0.5*sin(2*pi*9*(t-0.2))+0.1*sin(2*pi*30*t);
end

