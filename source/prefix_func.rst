Префикс-функция
"""""""""""""""
Дана строка :math:`s[0 \ldots n-1]`. Требуется вычислить для неё префикс-функцию, т.е. массив чисел :math:`\pi[0 \ldots n-1]`, где :math:`\pi[i]` определяется следующим образом: это такая наибольшая длина наибольшего собственного суффикса подстроки :math:`s[0 \ldots i]`, совпадающего с её префиксом (собственный суффикс — значит не совпадающий со всей строкой). В частности, значение :math:`\pi[0]` полагается равным нулю.

.. table:: Например, для строки "abcabcd" префикс-функция равна: [0, 0, 0, 1, 2, 3, 0], что означает:

    +------------------------+------------+----------+----------------------+
    | строка                 | совпадает с суффиксом | префикс длины        |
    +========================+=======================+======================+
    | a                      | |no|                  | 0                    |
    +------------------------+-----------------------+----------------------+
    | ab                     | |no|                  | 0                    |
    +------------------------+-----------------------+----------------------+
    | abc                    | |no|                  | 0                    |
    +------------------------+-----------------------+----------------------+
    | abca                   | |yes|                 | 1                    |
    +------------------------+-----------------------+----------------------+
    | abcab                  | |yes|                 | 2                    |
    +------------------------+-----------------------+----------------------+
    | abcabc                 | |yes|                 | 3                    |
    +------------------------+-----------------------+----------------------+
    | abcabcd                | |no|                  | 0                    |
    +------------------------+-----------------------+----------------------+



|no| Тривиальный алгоритм :math:`O(n ^ 3)`
""""""""""""""""""""""""""""""""""""""""""

.. code-block:: text

    vector<int> prefix_function (string s) {
        int n = (int) s.length();
        vector<int> pi (n);
        for (int i=0; i<n; ++i)
            for (int k=0; k<=i; ++k)
                if (s.substr(0,k) == s.substr(i-k+1,k))
                    pi[i] = k;
        return pi;
    }



|yes| Итоговый аггоритм :math:`O(n)`
""""""""""""""""""""""""""""""""""""""""""

* Считать значения префикс-функции :math:`\pi[i]` будем по очереди: от :math:`i=1` к :math:`i=n-1` (значение :math:`\pi[0]` просто присвоим равным нулю).

* Для подсчёта текущего значения :math:`\pi[i]` мы заводим переменную :math:`j`, обозначающую длину текущего рассматриваемого образца. Изначально :math:`j = \pi[i-1]`.

* Тестируем образец длины :math:`j`, для чего сравниваем символы :math:`s[j]` и :math:`s[i]`. Если они совпадают — то полагаем :math:`\pi[i] = j+1` и переходим к следующему индексу :math:`i+1`. Если же символы отличаются, то уменьшаем длину j, полагая её равной :math:`\pi[j-1]`, и повторяем этот шаг алгоритма с начала.

* Если мы дошли до длины :math:`j=0` и так и не нашли совпадения, то останавливаем процесс перебора образцов и полагаем :math:`\pi[i] = 0` и переходим к следующему индексу :math:`i+1`.


.. code-block:: text

    vector<int> prefix_function (string s) {
        int n = (int) s.length();
        vector<int> pi (n);
        for (int i=1; i<n; ++i) {
            int j = pi[i-1];
            while (j > 0 && s[i] != s[j])
                j = pi[j-1];
            if (s[i] == s[j])  ++j;
            pi[i] = j;
        }
        return pi;
    }

_____________________________

Применения
""""""""""

Поиск подстроки в строке. Алгоритм Кнута-Морриса-Пратта :math:`O(n + m)`
----------------------------------------------------------------------------

:math:`O(n + m)` времени и :math:`O(n)` памяти.

Эта задача является классическим применением префикс-функции (и, собственно, она и была открыта в связи с этим).

Дан текст :math:`t` и строка :math:`s`, требуется найти и вывести позиции всех вхождений строки :math:`s` в текст :math:`t`.

Обозначим для удобства через :math:`n` длину строки :math:`s`, а через :math:`m` — длину текста :math:`t`.

#. Образуем строку :math:`s + \# + t`, где символ :math:`\#` — это разделитель, который не должен нигде более встречаться.

#. Посчитаем для этой строки префикс-функцию.

#.  #. Теперь рассмотрим её значения, кроме первых :math:`n+1` (которые, как видно, относятся к строке :math:`s` и разделителю).
    #.  Но в нашем случае это :math:`\pi[i]` — фактически длина наибольшего блока совпадения со строкой :math:`s` и оканчивающегося в позиции :math:`i`. Больше, чем :math:`n`, эта длина быть не может — за счёт разделителя. А вот равенство :math:`\pi[i] = n` (там, где оно достигается), означает, что в позиции :math:`i` оканчивается искомое вхождение строки s (только не надо забывать, что все позиции отсчитываются в склеенной строке :math:`s+\#+t`).

Таким образом, если в какой-то позиции :math:`i` оказалось :math:`\pi[i] = n`, то в позиции :math:`i - (n + 1) - n + 1 = i - 2 n` строки :math:`t` начинается очередное вхождение строки :math:`s` в строку :math:`t`.

.. code-block:: cpp

    #include <bits/stdc++.h>

    using namespace std;

    typedef long long ll;

    vector<int> pf(string s) {
        int n = (int) s.length();
        vector<int> pi (n);
        for (int i=1; i<n; ++i) {
            int j = pi[i-1];
            while (j > 0 && s[i] != s[j])
                j = pi[j-1];
            if (s[i] == s[j])  ++j;
            pi[i] = j;
        }
        return pi;
    }
    int main() {
        ios::sync_with_stdio(0);
        cin.tie(0);

        string s, t;
        cin >> s >> t;
        auto pfv = pf(s + "#" + t);
        vector<ll> ans;
        for (int i = s.size() + 1; i < pfv.size(); i++) {
            if (pfv[i] == s.size()) {
                ans.push_back(i - 2 * s.size() + 1);
            }
        }
        cout << ans.size() << "\n";
        for (auto i : ans) {
            cout << i << " ";
        }
        return 0;
    }



.. |no| replace:: ❌
.. |yes| replace:: ✔
