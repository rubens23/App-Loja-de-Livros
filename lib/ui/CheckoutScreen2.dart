import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wordpress_book_app/data/payment/PaymentRepository.dart';
import 'package:wordpress_book_app/data/payment/PaymentRequest.dart';
import 'package:wordpress_book_app/data/payment/pix/PixPaymentRequest.dart';
import 'package:wordpress_book_app/data/payment/pix/PixPaymentResponse.dart';
import 'package:wordpress_book_app/data/user/Address.dart';

import '../data/cart/Cart.dart';
import 'CheckoutScreen3.dart';
import 'colors.dart';

class CheckoutScreen2 extends StatefulWidget{
  final Cart cart;
  final Address address;

  const CheckoutScreen2({super.key, required this.cart, required this.address});

  @override
  _CheckoutScreenState2 createState() => _CheckoutScreenState2();

}

class _CheckoutScreenState2 extends State<CheckoutScreen2>{
  //os valores dessas variaveis serão substituidos
  //por valores reais
  final frete = 12.50;
  final total = 43.40;


  String _qrCodeUrl = '';
  String? _ticketUrl;

  final TextEditingController _cpfController = TextEditingController();

  String _metodoPagamento = "Pix";
  bool _exibirQRCode = false;

  // Instância do PaymentRepository
  final PaymentRepository _paymentRepository = PaymentRepository();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.primaryColor,
      title: Center(
        child: Text("Finalização de Compra",style: TextStyle(
          fontSize: 24,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
        )),
      ),),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildResumoCompra(),
        
        
        
            SizedBox(height: 40,),
            _buildOpcoesPagamento(),
            SizedBox(height: 20,),
            if(_metodoPagamento == "Pix") _buildPagamentoPix(),
            if(_metodoPagamento == "Cartão") _buildFormularioCartao(),
            SizedBox(height: 40,),
        
        
            _buildBotaoConfirmarCompra()
        
        
          ],
        ),),
      ),
    );
  }


  void _finalizarPagamento() async{
    if(_metodoPagamento == "Pix"){
      final cpf = _cpfController.text.trim();
      final valor = total;
      
      //final response = await _paymentRepository.payByPix(cpf, valor, context);



          // //gerar o pedido
          // PixPaymentResponse pixPaymentResponse = PixPaymentResponse(id: response.id, status: response.status, statusDetail: response.statusDetail, qrCode: response.qrCode,
          //     qrCodeBase64: response.qrCodeBase64, ticketUrl: response.ticketUrl, vencimento: response.vencimento);
          //
          // //se o pedido é por pix o pagamento ainda vai ser feito
          // //não tem payment id pois o pagamento ainda não foi feito nesse ponto
          // PaymentRequest paymentRequest = PaymentRequest(status: "pendente", paymentId: "", paymentMethod: "Pix");




          final orderResponse = await _paymentRepository.makeNewOrder(
          widget.cart,
          widget.address,
          context);

          if(orderResponse.data == null){
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Erro ao criar o pedido. Tente novamente."))
            );
            return;
          }


          if(orderResponse.data!.orderStatus == "pending_payment"){

            //gerar o pix
            final pixPaymentResponse = await _paymentRepository.payByPix(cpf, valor, context);
            //atualizar o pedido com o pix gerado
            if(pixPaymentResponse == null){
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Erro ao gerar o pagamento Pix. Tente novamente."))
              );
              return;
            }
            await _paymentRepository.updateOrderWithPix(orderResponse.data!.id, pixPaymentResponse, context);

            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CheckoutScreen3(order: orderResponse.data!,),
                )
            );

          }else{
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(orderResponse.error!))
            );

          }






        //ScaffoldMessenger.of(context).showSnackBar(
        //  SnackBar(content: Text("Erro ao processar pagamento. Tente novamente."))
        //);

    }
  }

  Widget _buildResumoCompra(){
    return   Card(
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(16),
        child:
        Column(
          children: [
            Row(
                children: [
                  Text("Compra", style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.normal,
                      color: AppColors.primaryTextColor
                  ),),
                  Spacer(),
                  Text("R\$ ${(widget.cart.totalAmount).toStringAsFixed(2)}", style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.normal,
                      color:AppColors.primaryTextColor
                  ),),
                ]

            ),
            Row(
                children: [
                  Text("Frete", style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.normal,
                      color: AppColors.primaryTextColor
                  ),),
                  Spacer(),
                  Text("R\$ ${frete.toStringAsFixed(2)}", style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.normal,
                      color: AppColors.primaryTextColor
                  ),),
                ]
            ),
            Row(
                children: [
                  Text("Total", style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.normal,
                      color: Colors.black
                  ),),
                  Spacer(),
                  Text("R\$ ${(widget.cart.totalAmount + frete).toStringAsFixed(2)}", style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.normal,
                      color: Colors.black
                  ),),
                ]
            ),


          ],

        )
        ,


      ),
    );
  }

  Widget _buildOpcoesPagamento() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Pagamento", style: TextStyle(fontSize: 24, fontFamily: 'Roboto', fontWeight: FontWeight.normal, color: Colors.black),),
        SizedBox(height: 20,),
        Row(
          children: [
            Expanded(child: ElevatedButton(
                onPressed: (){
                  //arrumar esse set state

                setState((){
                  _metodoPagamento = "Pix";
                  _exibirQRCode = false;
                });


                },


                child: Text("Pix", style: TextStyle(fontFamily: 'Roboto'),),
                style: ElevatedButton.styleFrom(
                    backgroundColor: _metodoPagamento == "Pix" ? AppColors.primaryColor : Colors.grey[300],
                    foregroundColor: _metodoPagamento == "Pix" ? Colors.white : Colors.black
                )
            )
            ),
            SizedBox(width: 10,),
            Expanded(child: ElevatedButton(
                onPressed: (){
                  setState(() {
                    _metodoPagamento = "Cartão";
                  });
                },
                child: Text("Cartão", style: TextStyle(fontFamily: 'Roboto'),),
            style: ElevatedButton.styleFrom(
              backgroundColor: _metodoPagamento == "Cartão" ? AppColors.primaryColor : Colors.grey[300],
              foregroundColor: _metodoPagamento == "Cartão" ? Colors.white : Colors.black,
            ),))

          ],
        )
      ],
    );
  }


  Widget _buildBotaoConfirmarCompra() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _finalizarPagamento,
          child: Text(
            'Confirmar Compra',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.normal,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPagamentoPix() {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 20,),
          Text(
            'CPF',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: AppColors.primaryColor,
              fontFamily: 'Roboto',
            ),
          ),
          TextField(
            controller: _cpfController,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
              ),
            ),
          ),
          SizedBox(height: 20,),

          ElevatedButton(
              onPressed: (){

                setState(() {
                  _exibirQRCode = true;

                });
              },
              child: Text("Gerar Pix Copia e Cola",
          style: TextStyle(fontFamily: 'Roboto'),
              ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white
            ),
          ),
          if (_exibirQRCode)
            Column(
              children: [
                SizedBox(height: 20),
                Image.memory(
                  base64Decode(_qrCodeUrl),
                  height: 150,
                  width: 150,
                ),
                SizedBox(height: 10),
                SelectableText("Chave PIX: $_ticketUrl", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Roboto')),
                IconButton(
                  icon: Icon(Icons.copy, color: AppColors.primaryColor),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: "123456789"));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Chave Pix copiada!"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildFormularioCartao() {
    //aqui vai o formulario de cartão
    return Container(
      child: Text(""),
    );

  }


}

