
****************
sublime settings
****************

.. raw:: html

    <style> .red {color:red} </style>

.. role:: red


Preferemces -> Settings and replace


"word_wrap": true
"highlight_line": true

plugins:


* `CppFastOlympicCoding <https://packagecontrol.io/packages/CppFastOlympicCoding>`_ (testing + EasyClangComplete + debug + ...) `codeforces <https://codeforces.com/blog/entry/60627>`_ :red:`2580` `author <https://codeforces.com/profile/UnstoppableSolveMachine>`_

* `Terminus <https://packagecontrol.io/packages/Terminus>`_ (terminal in sublime)

* `gruvbox <https://packagecontrol.io/packages/gruvbox>`_ (theme)

* `EasyClangComplete <https://packagecontrol.io/packages/EasyClangComplete>`_ (c++ auto complete)

* `BracketHighlighter <https://packagecontrol.io/packages/BracketHighlighter>`_ (Brackets)

* `SideBarEnhancements <https://packagecontrol.io/packages/SideBarEnhancements>`_

* `JEDI Python autocompletion <https://packagecontrol.io/packages/Jedi%20-%20Python%20autocompletion>`_

* `Restructured Text RST Snippets <https://packagecontrol.io/packages/Restructured%20Text%20(RST)%20Snippets>`_


.. code-block:: json

	{
		"target": "terminus_open",
		"cmd" : ["python3", "$file"],
		"working_dir": "${file_path}",
		"auto_close": false,
	}

.. code-block:: json
	
	{
		"target": "terminus_open",
		"shell_cmd": "g++ $file && echo starts && time ./a.out",
		"working_dir": "${file_path}",
		"auto_close": false,
	}
