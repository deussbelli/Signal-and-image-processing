% Лабораторна робота з фільтрації сигналів
% Варіант 8
% Задані параметри фільтрів:

% ФВЧ (Фільтр високих частот)
fp_HPF = 16e3;  % Частота пропускання, Гц
fs_HPF = 15e3;  % Частота загородження, Гц
Rp_HPF = 3;     % Пульсації в смузі пропускання, дБ
Rs_HPF = 30;    % Загасання в смузі загородження, дБ

% РФ (Режекторний фільтр)
fp_RF = [10e3, 15e3]; % Частота пропускання, Гц
fs_RF = [9e3, 16e3];  % Частота загородження, Гц
Rp_RF = 2;            % Пульсації в смузі пропускання, дБ
Rs_RF = 30;           % Загасання в смузі загородження, дБ

% Загальні параметри
Um = [1, 0.5, 0.2, 0.1]; % Амплітуди складових сигналу
F = [10e3, 20e3, 40e3, 100e3]; % Частоти складових сигналу, Гц
fc = 30e3;              % Частота зрізу для варіантів 7 і 8, Гц

% ------------------- Розрахунок мінімальних параметрів фільтрів -------------------

Fs = 200e3;  % Частота дискретизації, Гц

% Нормалізовані частоти
Wp_HPF = fp_HPF / (Fs/2);
Ws_HPF = fs_HPF / (Fs/2);
Wp_RF = fp_RF / (Fs/2);
Ws_RF = fs_RF / (Fs/2);

% Розрахунок порядку та частоти зрізу для фільтрів Баттерворта
[n_HPF, Wn_HPF] = buttord(Wp_HPF, Ws_HPF, Rp_HPF, Rs_HPF);
[b_HPF, a_HPF] = butter(n_HPF, Wn_HPF, 'high');

[n_RF, Wn_RF] = buttord(Wp_RF, Ws_RF, Rp_RF, Rs_RF);
[b_RF, a_RF] = butter(n_RF, Wn_RF, 'stop');

% ------------------- Побудова АЧХ та ФЧХ -------------------

% АЧХ та ФЧХ для ФВЧ
figure;
freqz(b_HPF, a_HPF, 1024, Fs);
title('АЧХ та ФЧХ ФВЧ Баттерворта');

% АЧХ та ФЧХ для РФ
figure;
freqz(b_RF, a_RF, 1024, Fs);
title('АЧХ та ФЧХ РФ Баттерворта');

% ------------------- Генерація сигналу -------------------

N = 512;                   % Кількість відліків
ts = 100 / min(F);         % Тривалість сигналу
t = linspace(0, ts, 2*N);  % Вектор часу
x = Um(1)*sin(2*pi*F(1)*t) + Um(2)*sin(2*pi*F(2)*t) + ...
    Um(3)*sin(2*pi*F(3)*t) + Um(4)*sin(2*pi*F(4)*t);

% ------------------- Фільтрація сигналу -------------------

% Прохід через ФВЧ
y_HPF = filter(b_HPF, a_HPF, x);

% Прохід через РФ
y_RF = filter(b_RF, a_RF, x);

% Ідеально відфільтрований сигнал для ФВЧ (залишаються компоненти > fp_HPF)
x_ideal_HPF = Um(3)*sin(2*pi*F(3)*t) + Um(4)*sin(2*pi*F(4)*t);

% Ідеально відфільтрований сигнал для РФ (залишаються компоненти < fp_RF(1) та > fp_RF(2))
x_ideal_RF = Um(1)*sin(2*pi*F(1)*t) + Um(4)*sin(2*pi*F(4)*t);

% ------------------- Побудова графіків початкового, відфільтрованого та ідеального сигналів -------------------

% Для ФВЧ
figure;
plot(t, x, 'b', 'DisplayName', 'Початковий сигнал');
hold on;
plot(t, y_HPF, 'g', 'DisplayName', 'Сигнал після ФВЧ');
plot(t, x_ideal_HPF, 'r--', 'DisplayName', 'Ідеально відфільтрований сигнал');
title('Фільтрація ФВЧ Баттерворта');
xlabel('Час (с)');
ylabel('Амплітуда');
legend;
hold off;

% Для РФ
figure;
plot(t, x, 'b', 'DisplayName', 'Початковий сигнал');
hold on;
plot(t, y_RF, 'g', 'DisplayName', 'Сигнал після РФ');
plot(t, x_ideal_RF, 'r--', 'DisplayName', 'Ідеально відфільтрований сигнал');
title('Фільтрація РФ Баттерворта');
xlabel('Час (с)');
ylabel('Амплітуда');
legend;
hold off;

% ------------------- Спектральний аналіз -------------------

% Частота дискретизації
Fs = 1 / (t(2) - t(1));
f = Fs * (0:N-1) / (2*N-1);

% Спектральний аналіз вхідного та відфільтрованих сигналів
sp_x = abs(fft(x, 2*N)) / N; sp_x(1) = sp_x(1)/2;
sp_y_HPF = abs(fft(y_HPF, 2*N)) / N; sp_y_HPF(1) = sp_y_HPF(1)/2;
sp_y_RF = abs(fft(y_RF, 2*N)) / N; sp_y_RF(1) = sp_y_RF(1)/2;

% Спектри
figure;
stem(f, sp_x(1:N), 'b', 'DisplayName', 'Вихідний сигнал');
hold on;
stem(f, sp_y_HPF(1:N), 'g', 'DisplayName', 'Відфільтрований ФВЧ');
stem(f, sp_y_RF(1:N), 'r', 'DisplayName', 'Відфільтрований РФ');
title('Спектри сигналів');
xlabel('Частота (Гц)');
ylabel('Амплітуда');
legend;
hold off;

% ------------------- Додатковий синтез фільтрів для ФВЧ з n = 3 та 5 -------------------

% Параметри для синтезу ФВЧ
n_values = [3, 5];
fc_norm = fc / (Fs/2);  % Нормалізована частота зрізу

for n = n_values
    [b_test, a_test] = butter(n, fc_norm, 'high');  % Створення ФВЧ
    
    % Фільтрація сигналу
    y_test = filter(b_test, a_test, x);
    
    % Побудова фільтрації
    figure;
    plot(t, x, 'b', 'DisplayName', 'Початковий сигнал');
    hold on;
    plot(t, y_test, 'g', 'DisplayName', sprintf('Сигнал після ФВЧ порядку %d', n));
    plot(t, x_ideal_HPF, 'r--', 'DisplayName', 'Ідеально відфільтрований сигнал');
    title(['Фільтрація ФВЧ Баттерворта (порядок ', num2str(n), ')']);
    xlabel('Час (с)');
    ylabel('Амплітуда');
    legend;
    hold off;
    
    % Спектральний аналіз
    sp_y_test = abs(fft(y_test, 2*N)) / N; sp_y_test(1) = sp_y_test(1)/2;
    figure;
    stem(f, sp_x(1:N), 'b', 'DisplayName', 'Вихідний сигнал');
    hold on;
    stem(f, sp_y_test(1:N), 'g', 'DisplayName', sprintf('Відфільтрований сигнал порядку %d', n));
    title(['Спектральний аналіз ФВЧ Баттерворта (порядок ', num2str(n), ')']);
    xlabel('Частота (Гц)');
    ylabel('Амплітуда');
    legend;
    hold off;
end

% ------------------- Висновки -------------------
% У даній лабораторній роботі було розраховано та спроектовано ФВЧ і РФ Баттерворта
% для заданих параметрів частоти пропускання, загородження, пульсацій і затухання.
% Було здійснено фільтрацію згенерованого сигналу, що складається з кількох гармонічних складових.
% Після застосування фільтрів результати фільтрації досліджено у часовій та частотній областях.
% Додатково проаналізовано синтез ФВЧ порядку n = 3 та n = 5, що дозволило дослідити вплив 
% порядку фільтру на результуючу амплітудно-частотну характеристику.
