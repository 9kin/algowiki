Бинарное возведение в степень
=================================

Бинарное (двоичное) возведение в степень — это приём, позволяющий возводить любое число в :math:`n`-ую степень за :math:`O(log(n))` умножений (вместо :math:`n` умножений при обычном подходе).

Алгоритм
++++++++++



.. math:: 
   
    a^{n} = 
     \begin{cases}
       1 &n = 0\\
       (a^{n/2}) ^2 = a^{n/2} \times a^{n/2} &n = 2k\\
       a^{n-1} \times n &n \neq 2k
     \end{cases}

________________________

.. code-block:: cpp

    ll binpow (ll a, ll n) {
        if (n == 0)
            return 1;
        if (n % 2 == 1)
            return binpow(a, n - 1) * a;
        else {
            ll b = binpow(a, n / 2);
            return b * b;
        }
    }


:math:`a^{n} (mod) p`
++++++++++++++++++++++

Поскольку мы знаем, что :math:`mod` не вмешивается в умножение

.. math:: 
    
    a\times b\equiv (a \bmod m)\times(b \bmod m) \pmod m

.. code-block:: cpp

    ll binpow (ll a, ll n, ll p) {
        if (n == 0)
            return 1;
        if (n % 2 == 1)
            return binpow(a, n - 1, p) * a % p;
        else {
            ll b = binpow(a, n / 2, p);
            return b * b % p;
        }
    }

`Возведение в степень <https://www.e-olymp.com/ru/problems/273>`_