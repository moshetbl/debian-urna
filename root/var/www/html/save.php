<html>
  <head>
    <meta charset="UTF-8">
    <style>
      body {
        background-color: #333;
        color: #AAA;
        font-family: Arial, Helvetica, sans-serif;
      }
      .msgbox {
        position: fixed;
        top: 50%;
        left: 50%;
        -webkit-transform: translate(-50%, -50%);
      }

      bold {
        font-weight: bold;
      }
      a {
        color: #DDD;
      }
    </style>
  </head>
  <body>
    <h1>Tela do Mesário</h1>
    <div class='msgbox'>
      <?php
      $myfile = fopen("/media/usb0/arquivo-da-urna.txt", "w");
      if ($myfile) {
        $txt = "Arquivo gerado em " . (new \DateTime())->format('Y-m-d H:i:s');
        fwrite($myfile, $txt);
        fclose($myfile);
        echo $txt;
      } else {
        echo "Não foi possível gravar arquivo. Verifique se o dispositivo está conectado corretamente e tente novamente.";
      }
      ?>
      <br />
      <br />
      <a href="javascript: history.back();">Voltar</a>
    </div>
  </body>
</html>
