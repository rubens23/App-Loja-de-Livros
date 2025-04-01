import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordpress_book_app/data/payment/PaymentRepository.dart';
import 'package:wordpress_book_app/ui/colors.dart';

import '../data/order/OrderResponse.dart';
import '../data/payment/pix/PixPaymentResponse.dart';
import 'MyHomePage.dart';

class CheckoutScreen3 extends StatefulWidget{
  final OrderResponse order;

  const CheckoutScreen3({super.key, required this.order});

  @override
  _CheckoutScreen3State createState() => _CheckoutScreen3State();



}

class _CheckoutScreen3State extends State<CheckoutScreen3>{
  final paymentRepository = PaymentRepository();
  PixPaymentResponse? _paymentDetails;

  String formaDePagamento = "Pix";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_fetchPaymentDetails(widget.order.paymentId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.primaryColor,
      leading: IconButton(onPressed: (){
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => MyHomePage()),
            (Route<dynamic> route) => false,
        );

      }
          , icon: Icon(Icons.close, color: Colors.white,)),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: AppColors.primaryColor,
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Center(
                    child: Icon(Icons.check_circle, color: AppColors.darkerGreen, size: 88,),
                  ),
                  SizedBox(height: 10,),
                  Text(widget.order.orderStatus, style: TextStyle(fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.white),),
                  SizedBox(height: 10,),
                  //formato esperado "24 de março de 2025 - 13:55"
                  Text(widget.order.createdAt.toString(), style: TextStyle(fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white),),
                  SizedBox(height: 40,),

                ],
              ),
            ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        SizedBox(
                          width: double.infinity ,
                          child: Text("Endereço", style: TextStyle(fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              ),),
                        ),
                        Text("${widget.order.address.street}, ${widget.order.address.city}, ${widget.order.address.state}, ${widget.order.address.country} - ${widget.order.address.postalCode}", style: TextStyle(fontFamily: 'Roboto',
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            ),),

                      ],
                                      ),
                    ),
                  ),
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            const Text("Forma de Pagamento", style: TextStyle(fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),),
                            SizedBox(height: 10,),
                            if (formaDePagamento == "Pix") Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                        children: [
                                          Icon(Icons.pix_outlined),
                                          SizedBox(width: 10,),
                                          Text("PIX", style: TextStyle(fontFamily: 'Roboto',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),),
                                        ]

                                    ),
                                    SizedBox(height: 20,),
                                    Text("Atenção! Siga as instruções abaixo para realizar seu pagamento PIX. "
                                        "Após a transferência, seu pagamento será aprovado na hora! "
                                        "É rápido, prático e seguro! :-)", style: TextStyle(fontFamily: 'Roboto',
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                    ),),
                                    SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Text("Vencimento: ", style: TextStyle(fontFamily: 'Roboto',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),),
                                        //formato vencimento: "25/03/2025 - 21:30"

                                        Text(_paymentDetails?.vencimento.toString() ?? '', style: TextStyle(fontFamily: 'Roboto',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                        ),),
                                      ],
                                    ),
                                    SizedBox(height: 20,),
                                    Row(
                                      children: [
                                        Icon(Icons.copy, color: AppColors.primaryColor,),
                                        SizedBox(width: 10,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("1. Copie o código abaixo", style: TextStyle(fontFamily: 'Roboto',
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                            ),),
                                            Text(_paymentDetails?.qrCode ?? '', style: TextStyle(fontFamily: 'Roboto',
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                              color: AppColors.primaryTextColor
                                            ),),


                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    SizedBox(
                                      width: double.infinity,
                                      child: OutlinedButton.icon(
                                        onPressed: () {
                                          // Ação ao clicar no botão
                                        },
                                        icon: Icon(Icons.copy, color: AppColors.primaryColor),
                                        label: Text("Copiar Código", style: TextStyle(color: AppColors.primaryColor)),
                                        style: OutlinedButton.styleFrom(
                                          side: BorderSide(color: AppColors.primaryColor, width: 2.5), // Borda roxa
                                          backgroundColor: Colors.transparent, // Fundo transparente
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8), // Borda arredondada (opcional)
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                    Row(
                                      children: [
                                        Icon(Icons.pix_outlined, color: AppColors.primaryColor,),
                                        SizedBox(width: 10,),
                                        Expanded(
                                          child: Text("2. Abra o aplicativo do seu banco, central de pagamentos ou "
                                              "instituição financeira e selecione o ambiente PIX",
                                            style: TextStyle(fontFamily: 'Roboto',
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                          ),),
                                        ),

                                      ],
                                    ),
                                    SizedBox(height: 20,),
                                    Row(
                                      children: [
                                        Icon(Icons.apps, color: AppColors.primaryColor,),
                                        SizedBox(width: 10,),
                                        Expanded(
                                          child: Text("3. No ambiente PIX, toque na opção \"Pix Copia e Cola\"",
                                            style: TextStyle(fontFamily: 'Roboto',
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                            ),),
                                        ),

                                      ],
                                    ),
                                    SizedBox(height: 20,),
                                    Row(
                                      children: [
                                        Icon(Icons.check_circle_outline, color: AppColors.primaryColor,),
                                        SizedBox(width: 10,),
                                        Expanded(
                                          child: Text("4. Agora é só realizar o pagamento e aguardar a confirmação",
                                            style: TextStyle(fontFamily: 'Roboto',
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                            ),),
                                        ),

                                      ],
                                    ),
                                    SizedBox(height: 20,),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.info_outline, color: AppColors.primaryTextColor,),
                                        SizedBox(width: 10,),
                                        Expanded(
                                          child: RichText(
                                            text: TextSpan(
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.normal,
                                                fontSize: 14,
                                                color: Colors.black, // Certifique-se de definir a cor do texto, pois TextSpan não assume automaticamente
                                              ),
                                              children: [
                                                TextSpan(text: "Atenção! O código PIX criado tem validade de 25/03/2025 - 21:30. "),
                                                TextSpan(
                                                  text: "Após o vencimento, seu pedido será cancelado automaticamente.\n\n",
                                                  style: TextStyle(fontWeight: FontWeight.bold), // Apenas essa parte em negrito
                                                ),
                                                TextSpan(
                                                  text: "O pagamento por PIX só funcionará no banco, instituição financeira "
                                                      "ou central de pagamentos em que você possua uma Chave PIX cadastrada!",
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),


                                      ],
                                    ),


                                  ],
                                ) else formaDePagamento == "Cartão" ? Text("Cartão")
                            : Text("algo")

                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,)

                  ]
                ),





          ],
        ),
      ),
    );
  }

  void _fetchPaymentDetails(String paymentId) async{
    try{
      final paymentDetails = await paymentRepository.getPaymentDetails(
          context,
      paymentId,
      );


      //atualizar o estado com os dados de pagamento
      setState(() {
        _paymentDetails = paymentDetails;

      });
    }catch(e){
      print("Erro ao buscar detalhes do pagamento: $e");

    }
  }

}