Дп на поддеревьях
"""""""""""""""""

:math:`O(V + E)` Максимальное паросочетание в дереве
""""""""""""""""""""""""""""""""""""""""""""""""""""""

#.  Состояние динамики:

	* dp[u].no_take - максимальное парасочетание в поддереве в вершине u, не беря вершину в парасочентание

    * dp[u].take - максимальное парасочетание в поддереве в вершине u, беря вершину в парасочентание

#. База:
	
	dp[листа].take = 0, dp[листа].take = 0;

#. Переходы:

	:math:`v` - вершина, :math:`u` - ребёнок 


	* dp[u].no_take += max(dp[v].take, dp[v].no_take); - без разницы какое состояние взять

	* dp[u].take = dp[u].no_take + dp[v].no_take - max(dp[v].take, dp[v].no_take); - надо взять вершину :math:`u` с :math:`v` а с отальными соеденяем

#. Где ответ:

.. code-block:: text

	max((ll) best_matcing[0].take, (ll) best_matcing[0].no_take);


code from gate ЛКЛ 2019 - Параллель B - День 03 (ДП по подмножествам и поддеревьям)

.. code-block:: cpp

	#include <bits/stdc++.h>

	using namespace std;

	typedef long long ll;

	const ll INF = (ll) 1e18;

	struct three {
	    ll no_take = 0, take = 0, pred = -1;
	};

	vector<vector<ll>> graph;
	vector<bool> used;
	vector<three> best_matcing;

	void calculate_tree_best_matcing(ll vertex, ll prev_vertex) {
	    if (graph[vertex].size() == 0) {
	        return;
	    }
	    for (auto new_vertex : graph[vertex]) {
	        if (new_vertex != prev_vertex) {
	            calculate_tree_best_matcing(new_vertex, vertex);
	        }
	    }
	    for (auto new_vertex : graph[vertex]) {
	        if (new_vertex != prev_vertex) {
	            best_matcing[vertex].no_take += max(best_matcing[new_vertex].no_take, best_matcing[new_vertex].take);
	        }
	    }
	    pair<ll, ll> ans = {-INF, -1};
	    for (auto new_vertex : graph[vertex]) {
	        if (new_vertex != prev_vertex) {
	            ll curent_ans =
	                    best_matcing[vertex].no_take + best_matcing[new_vertex].no_take -
	                    max(best_matcing[new_vertex].no_take, best_matcing[new_vertex].take);
	            if (curent_ans > ans.first) {
	                ans = {curent_ans, new_vertex};
	            }
	        }
	    }
	    best_matcing[vertex].pred = ans.second;
	    best_matcing[vertex].take = ans.first + 1;
	}

	void print(ll vertex, ll prev_vertex) {
	    for (auto new_vertex : graph[vertex]) {
	        if (new_vertex != prev_vertex) {
	            if (best_matcing[vertex].pred != -1 && best_matcing[vertex].pred == new_vertex &&
	                best_matcing[vertex].take > best_matcing[vertex].no_take) {
	                cout << vertex + 1 << " " << new_vertex + 1 << "\n";
	            }
	            print(new_vertex, vertex);
	        }
	    }
	}

	int main() {
	    ll n, m, a, b;
	    cin >> n >> m;
	    used.resize(n, false);
	    best_matcing.resize(n);
	    graph.resize(n);
	    for (int i = 0; i < m; i++) {
	        cin >> a >> b;
	        a--, b--;
	        graph[a].push_back(b);
	        graph[b].push_back(a);
	    }
	    calculate_tree_best_matcing(0, -1);
	    cout << max((ll) best_matcing[0].take, (ll) best_matcing[0].no_take) << "\n";
	    print(0, -1);
	    return 0;
	}


:math:`O(V + E)` Задача о независимом множестве
""""""""""""""""""""""""""""""""""""""""""""""""

#. Состояние динамики:

	* dp[u][0] - максимальное множество без вершины :math:`u`

 	* dp[u][1] - максимальное множество с вершиной :math:`u`

#. База:

	* нету

#. Переходы:

	:math:`v` - дети вершины :math:`u`

   * dp[u][0] = sum(max(dp[v][0], dp[v][1]))

   * dp[u][1] = sum(dp[v][0]) + 1

#. Где ответ:

.. code-block:: text

	max((ll) dp[0][0], (ll) dp[0][1]);


Невзвешанное дерево (вес 1)
===========================


.. image:: https://i.imgur.com/7eBP9Pj.png



.. code-block:: cpp

	#include <bits/stdc++.h>
 
	using namespace std;
	 
	typedef long long ll;
	 
	vector<bool> used;
	vector<pair<ll, ll>> dp;
	vector<vector<ll>> v;
	 
	void dfs(ll u) {
	    used[u] = true;
	    for (auto q : v[u]) {
	        dfs(q);
	    }
	    ll sum1 = 0, sum0 = 0;
	    for (auto q: v[u]) {
	        dp[u].second += dp[q].first;
	        dp[u].first += max(dp[q].first, dp[q].second);
	    }
	    dp[u].second++;
	}
	 
	int main() {
	    ios::sync_with_stdio(0);
	    cin.tie(0);
	    ll n, x, root;
	    cin >> n;
	    used.resize(n);
	    dp.resize(n);
	    v.resize(n);
	    for (int i = 0; i < n; i++) {
	        cin >> x;
	        if (x == 0) {
	            root = i;
	        } else {
	            x--;
	            v[x].push_back(i);
	        }
	    }
	    dfs(root);
	    cout << max(dp[root].first, dp[root].second);
	    return 0;
	}


Взвешанное дерево 
==================
Добавим в случае dp[u].second += w[u];

.. image:: https://i.imgur.com/aiwhCMB.png

.. code-block:: cpp

	#include <bits/stdc++.h>
	 
	using namespace std;
	 
	typedef long long ll;
	 
	vector<bool> used;
	vector<pair<ll, ll>> dp;
	vector<vector<ll>> v;
	vector<ll> w;
	 
	void dfs(ll u) {
	    used[u] = true;
	    for (auto q : v[u]) {
	        dfs(q);
	    }
	    ll sum1 = 0, sum0 = 0;
	    for (auto q: v[u]) {
	        dp[u].second += dp[q].first;
	        dp[u].first += max(dp[q].first, dp[q].second);
	    }
	    dp[u].second += w[u];
	}
	 
	int main() {
	    ios::sync_with_stdio(0);
	    cin.tie(0);
	    ll n, x, root, y;
	    cin >> n;
	    used.resize(n);
	    dp.resize(n);
	    v.resize(n);
	    w.resize(n);
	    for (int i = 0; i < n; i++) {
	        cin >> x >> y;
	        w[i] = y;
	        if (x == 0) {
	            root = i;
	 
	        } else {
	            x--;
	            v[x].push_back(i);
	        }
	    }
	    dfs(root);
	    cout << max(dp[root].first, dp[root].second);
	    return 0;
	}