Геометрия
=========


Вектор - направленныйй отрезок

Полярные кординаты - представление вектора с длиноной и углом

____________________


.. math::
    \overrightarrow{A} * \overrightarrow{B} = (a_x * b_x, a_y * b_y)

    \overrightarrow{A} * \overrightarrow{A} = \overrightarrow{A} ^ 2

    \overrightarrow{A} * 0 = 0

    \overrightarrow{A} * \overrightarrow{B} = \overrightarrow{B} * \overrightarrow{A}

    \overrightarrow{A} * (\overrightarrow{B} + C) = \overrightarrow{A} * \overrightarrow{B} + \overrightarrow{A} * C

    \overrightarrow{A} * (\overrightarrow{B} * C) = (\overrightarrow{A} * \overrightarrow{B}) * C


__________________________

Перевод из Декартовой в Полярную систему и обратно

.. math::
    (x, y) \Longrightarrow (a, \varphi)

    \varphi = \arctan \frac{y}{x}

    a = \sqrt{x ^ 2 + y ^ 2}

_________________________


.. math::
    (a, \varphi) \Longrightarrow (x, y)

    x = a * \cos \varphi

    y = a * \sin \varphi

-------------------------

Нормирование вектора

.. math::

    a = \sqrt{x ^ 2 + y ^ 2}

    (\frac{x}{a}; \frac{y}{a})

--------------------------

.. math::
    \overrightarrow{A} + \overrightarrow{B} = (a_x + b_x, a_y + b_y)


    \overrightarrow{A} - \overrightarrow{B} = (a_x - b_x, a_y - b_y)


.. code-block:: cpp

    #include <bits/stdc++.h>
     
    using namespace std;
     
    typedef long long ll;
    typedef long double ld;
     
    struct point {
        ld x, y;
     
        friend bool operator==(const point &f, const point &s) {
            return f.x == s.x && f.y == s.y;
        }
     
        friend bool operator!=(const point &f, const point &s) {
            return !(f.x == s.x && f.y == s.y);
        }
    };
     
    struct Coefficient {
        ld a, b, c;
     
        Coefficient(ld a_, ld b_, ld c_) {
            a = a_;
            b = b_;
            c = c_;
        }
     
        Coefficient(point p1, point p2) {
            a = p2.y - p1.y;
            b = -(p2.x - p1.x);
            c = -(a * p1.x + b * p1.y);
        }
     
        friend bool operator==(const Coefficient &f, const Coefficient &s) {
            return f.a == s.a && f.b == s.b && f.c == f.c;
        }
    };
     
    struct Vector {
        point p;
     
        Vector(point f, point s) { // f -> s
            p = {s.x - f.x, s.y - f.y};
        }
     
        Vector(point t) {
            p = t;
        }
     
        Vector(ld x, ld y) {
            p = {x, y};
        }
     
        friend Vector operator+(const Vector &f, const Vector &s) {
            return Vector(f.p.x + s.p.x, f.p.y + s.p.y);
        }
     
        friend Vector operator-(const Vector &f, const Vector &s) {
            return Vector(f.p.x - s.p.x, f.p.y - s.p.y);
        }
     
        friend ld operator*(const Vector &f, const Vector &s) {
            return f.p.x * s.p.y - f.p.y * s.p.x;
        }
     
        friend ld operator^(const Vector &f, const Vector &s) {
            return f.p.x * s.p.x + f.p.y * s.p.y;
        }
     
    };
     
    ld rast(point a, point b) {
        return sqrt((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y));
    }
     
     
    ld angle(point a, point b, point c) {
        auto Vec1 = Vector(a, c);
        auto Vec2 = Vector(a, b);
        return atan2(Vec1 * Vec2, Vec1 ^ Vec2);
    }
     
    ld point_to_vector(point p1, point p2, point p3) {
        point p; // point vector
        p.x = p2.x - p1.x;
        p.y = p2.y - p1.y;
        point pn; // point normal
        pn.x = -p.y;
        pn.y = p.x;
        point p4; // point p3 p4
        p4.x = p3.x + pn.x;
        p4.y = p3.y + pn.y;
        auto line = Coefficient(p3, p4);
        auto vector = Coefficient(p1, p2);
        ld DET = vector.a * line.b - line.a * vector.b;
        ld DETx = -vector.c * line.b - -line.c * vector.b;
        ld DETy = vector.a * -line.c - line.a * -vector.c;
        point P;
        P.x = DETx / DET;
        P.y = DETy / DET;
        return rast(P, p3);
    }
     
    ld Point_to_vector(point c, point a, point b) {
        if (angle(a, b, c) < 0 || angle(b, a, c) < 0) {
            return min(rast(c, a), rast(c, b));
        } else {
            return point_to_vector(a, b, c);
        }
    }
     
    bool p(point a, point b, point c, point d) {
        // c-d ? a-b
        auto p = Vector(d, c);
        auto v1 = Vector(d, a);
        auto v2 = Vector(d, b);
        auto vec1 = v1 * p;
        auto vec2 = v2 * p;
        if (!((vec1 <= 0 && vec2 <= 0) || (vec1 >= 0 && vec2 >= 0))) {
            return true;
        } else {
            return false;
        }
    }
     
    ld sq(vector<point> &fig) {
        ld res = 0;
        for (ll i = 0; i < fig.size(); i++) {
            point a = i ? fig[i - 1] : fig.back(), b = fig[i];
            res += Vector(a) * Vector(b);
        }
        return abs(res) / 2;
    }

    int main() {
        return 0;
    }