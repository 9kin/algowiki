Z-функция
"""""""""

Пусть дана строка :math:`s` длины :math:`n`. Тогда Z-функция от этой строки — это массив длины :math:`n`, :math:`i`-ый элемент которого равен наибольшему числу символов, начиная с позиции :math:`i`, совпадающих с первыми символами строки :math:`s`.

Иными словами, :math:`z[i]` — это наибольший общий префикс строки :math:`s` и её :math:`i`-го суффикса.

Примеры
"""""""

.. table:: Приведём для примера подсчитанную Z-функцию для нескольких строк

    +------------------------+-----------------------+
    | string                 | z-func                |
    +========================+=======================+
    | aaaaa                  | 0, 4, 3, 2, 1         |
    +------------------------+-----------------------+
    | aaabaab                | 0, 2, 1, 0, 2, 1, 0   |
    +------------------------+-----------------------+
    | abacaba                | 0, 0, 1, 0, 3, 0, 1   |
    +------------------------+-----------------------+


Тривиальный алгоритм
""""""""""""""""""""

Формальное определение можно представить в виде следующей элементарной реализации за :math:`O (n^2)`:

.. code-block:: text

    vector<int> z_function_trivial (string s) {
        int n = (int) s.length();
        vector<int> z (n);
        for (int i = 1; i < n; i++)
            while (i + z[i] < n && s[z[i]] == s[i+z[i]])
                z[i]++;
        return z;
    }

Эффективный алгоритм вычисления Z-функции :math:`O(n)`
""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. code-block:: text

    vector<ll> zf(string s) {
        vector<ll> z(s.size());
        for (int i = 1, l = 0, r = 0; i < s.size(); ++i) {
            if (i <= r)
                z[i] = min((ll)r - i + 1, z[i - l]);
            while (i + z[i] < s.size() && s[z[i]] == s[i + z[i]])
                z[i]++;
            if (i + z[i] - 1 > r)
                l = i, r = i + z[i] - 1;
        }
        return z;
    }


Применения
""""""""""

Поиск подстроки в строке :math:`O(n)`
--------------------------------------

Во избежании путаницы, назовём одну строку текстом :math:`t`, другую — образцом :math:`p`. Таким образом, задача заключается в том, чтобы найти все вхождения образца :math:`p` в текст :math:`t`.

Для решения этой задачи образуем строку :math:`s = p + \# + t`, т.е. к образцу припишем текст через символ-разделитель (который не встречается нигде в самих строках).

Посчитаем для полученной строки Z-функцию. Тогда для любого :math:`i` в отрезке :math:`[0; length(t)-1]` по соответствующему значению :math:`z[i + length(p) + 1]` можно понять, входит ли образец :math:`p` в текст :math:`t`, начиная с позиции :math:`i`: если это значение Z-функции равно :math:`length(p)`, то да, входит, иначе — нет.

Таким образом, асимптотика решения получилась :math:`O (length(t) + length(p))`. Потребление памяти имеет ту же асимптотику.


.. code-block:: cpp

    #include <bits/stdc++.h>

    using namespace std;

    typedef long long ll;

    vector<ll> zf(string s) {
        vector<ll> z(s.size());
        for (int i = 1, l = 0, r = 0; i < s.size(); ++i) {
            if (i <= r)
                z[i] = min((ll) r - i + 1, z[i - l]);
            while (i + z[i] < s.size() && s[z[i]] == s[i + z[i]])
                z[i]++;
            if (i + z[i] - 1 > r)
                l = i, r = i + z[i] - 1;
        }
        return z;
    }

    int main() {
        ios::sync_with_stdio(0);
        cin.tie(0);

        string p, t;
        cin >> p >> t;
        auto zfv = zf(p + "#" + t);
        vector<ll> ans;
        for (int i = p.size() + 1; i < p.size() + t.size() + 1; i++) {
            if (zfv[i] == p.size()) {
                ans.push_back(i - p.size());
            }
        }

        cout << ans.size() << "\n";
        for (auto i : ans) {
            cout << i << " ";
        }
        return 0;
    }


Сжатие строки
--------------


Дана строка :math:`s` длины :math:`n`. Требуется найти самое короткое её "сжатое" представление, т.е. найти такую строку :math:`t` наименьшей длины, что :math:`s` можно представить в виде конкатенации одной или нескольких копий :math:`t`.

Для решения посчитаем Z-функцию строки :math:`s`, и найдём первую позицию :math:`i` такую, что :math:`i + z[i] = n`, и при этом :math:`n` делится на :math:`i`. Тогда строку :math:`s` можно сжать до строки длины :math:`i`.


.. code-block:: cpp

    #include <bits/stdc++.h>

    using namespace std;

    typedef long long ll;

    vector<ll> zf(string s) {
        vector<ll> z(s.size());
        for (int i = 1, l = 0, r = 0; i < s.size(); ++i) {
            if (i <= r)
                z[i] = min((ll)r - i + 1, z[i - l]);
            while (i + z[i] < s.size() && s[z[i]] == s[i + z[i]])
                z[i]++;
            if (i + z[i] - 1 > r)
                l = i, r = i + z[i] - 1;
        }
        return z;
    }

    int main() {
        ios::sync_with_stdio(0);
        cin.tie(0);

        string s;
        cin >> s;
        auto z = zf(s);
        ll n = z.size();
        for (int i = 1; i < n; i++) {
            if (i + z[i] == n && n % i == 0) {
                cout << i;
                return 0;
            }
        }
        cout << s.size();
        return 0;
    }

