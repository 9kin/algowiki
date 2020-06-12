Бинарное возведение в степень
=================================

Бинарное (двоичное) возведение в степень — это приём, позволяющий возводить любое число в :math:`n`-ую степень за :math:`O(log(n))` умножений (вместо :math:`n` умножений при обычном подходе).

Алгоритм
++++++++++




.. math:: 
	a\in R 

	n = 2k
	
	a^n = (a^{n/2}) ^2 = a^{n/2} * a^{n/2}

___________________


.. math:: 
	a\in R 

	n != 2k
	
	a^n = a^{n-1} * n

________________________

.. code-block:: text

	long long binpow(long long a, long long b) {
	    if (b == 0)
		return 1;
	    long long res = binpow(a, b / 2);
	    if (b % 2)
		return res * res * a;
	    else
		return res * res;
	}

(деления на 2 заменены битовыми операциями)

.. code-block:: text

	long long binpow(long long a, long long b) {
	    long long res = 1;
	    while (b > 0) {
		if (b & 1)
		    res = res * a;
		a = a * a;
		b >>= 1;
	    }
	    return res;
	}

`Возведение в степень <https://www.e-olymp.com/ru/problems/273>`_





