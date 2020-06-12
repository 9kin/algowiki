livereload
""""""""""""""

.. code-block:: text
   
   sudo apt install ruby-dev
   sudo gem install rdoc -V
   sudo gem install guard -V
   sudo gem install guard-livereload -V

Заходим в нашу директорию с проектом

.. code-block:: text
   
   guard init

В файле `Guardfile <https://pastebin.com/TTS6wLgy>`_ меняем

.. code-block:: text

   watch(%r{public/.+\.(#{compiled_exts * '|'})})

на

.. code-block:: text

   watch(%r{.+\.(#{compiled_exts * '|'})})

Теперь запускаем «мониторинг»

.. code-block:: text

   guard

.. code-block:: text

   root@lxc:/home/lxc/algo# guard
   18:39:59 - INFO - LiveReload is waiting for a browser to connect.
   18:39:59 - INFO - Guard is now watching at '/home/lxc/algo'

