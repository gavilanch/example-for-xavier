<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="webformapp._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
  <h2>Formulario de ingreso de productos</h2>
    <asp:Image runat="server" ID="Image1" />
    <br />
    Fecha Ingreso
      <asp:TextBox ID="txtFechaIngreso" Text="2018-5-5" CssClass="fecha-ingreso" runat="server" Width="88px"></asp:TextBox>
    <br />
    Valor_Cordobas
      <asp:TextBox ID="txtValorCordoba" CssClass="valor-cordoba" runat="server" Width="129px"></asp:TextBox>


    <hr />

    Costo Dolar
      <asp:TextBox ID="txtCostoDolar" CssClass="costo-dolar" runat="server" Width="129px"></asp:TextBox>


    Tasa de Cambio
      <asp:TextBox ID="txtTasaDeCambio" CssClass="tasa-cambio" runat="server" Height="26px" Width="129px"></asp:TextBox>

    <script>
        $(function () {
            $(".fecha-ingreso").change(function () {
                var valorCordoba = $(".valor-cordoba").val();
                var fechaIngreso = $(this).val();
                buscarInformacionTasaDeCambio(fechaIngreso, valorCordoba);
            });

            $(".valor-cordoba").change(function () {
                var fechaIngreso = $(".fecha-ingreso").val();
                var valorCordoba = $(this).val();
                buscarInformacionTasaDeCambio(fechaIngreso, valorCordoba);
            });

            function buscarInformacionTasaDeCambio(fechaIngreso, valorCordoba) {
                if (fechaIngreso === '' || valorCordoba === '') { return; }

                var obj = { fecha: fechaIngreso };
                var objStr = JSON.stringify(obj);
               
                $.ajax({
                    url:  '<%= ResolveUrl("Default.aspx/ObtenerInformacionDolares") %>',
                    type: "POST",
                    data: objStr,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        var tasa = response.d;
                        $(".tasa-cambio").val(tasa);
                        var costoDolar = tasa * valorCordoba;
                        $(".costo-dolar").val(costoDolar);
                    },
                    error: function (response) {
                        console.log(response);
                        alert(response.responseJSON.Message);
                    }
                });

            }
        });
    </script>

</asp:Content>
