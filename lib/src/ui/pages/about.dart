import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                width: 100.0,
                height: 100.0,
                child: Image.asset(
                  "assets/images/icon.png",
                  fit: BoxFit.fill,
                ),
              ),
              Text("Flutter Ecommerce"),
              SizedBox(
                height: 16.0,
              ),
              Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis tristique sollicitudin nibh sit. Pellentesque elit eget gravida cum sociis natoque penatibus et. Morbi tristique senectus et netus et. Interdum posuere lorem ipsum dolor sit. Lacus suspendisse faucibus interdum posuere lorem ipsum dolor sit. Feugiat nibh sed pulvinar proin gravida hendrerit. Vitae purus faucibus ornare suspendisse sed nisi lacus sed viverra. Maecenas sed enim ut sem viverra aliquet. Facilisis volutpat est velit egestas dui id. Pulvinar elementum integer enim neque. Nec tincidunt praesent semper feugiat nibh sed pulvinar proin. Fermentum posuere urna nec tincidunt praesent semper feugiat nibh. Pharetra pharetra massa massa ultricies mi quis hendrerit dolor magna. Enim nulla aliquet porttitor lacus luctus accumsan tortor posuere ac. Lorem mollis aliquam ut porttitor leo a. Quis blandit turpis cursus in hac habitasse platea dictumst quisque. \n Fusce ut placerat orci nulla pellentesque dignissim enim sit amet. Nibh tortor id aliquet lectus proin nibh nisl condimentum. Pretium aenean pharetra magna ac placerat vestibulum lectus. Sed libero enim sed faucibus. Aliquet enim tortor at auctor urna nunc. Urna duis convallis convallis tellus id. Ullamcorper malesuada proin libero nunc consequat interdum varius sit amet. Placerat in egestas erat imperdiet. Eget nulla facilisi etiam dignissim diam quis enim lobortis scelerisque. Tristique et egestas quis ipsum. Diam volutpat commodo sed egestas. \ n Mauris ultrices eros in cursus turpis massa tincidunt dui ut. Suspendisse sed nisi lacus sed viverra tellus in. Leo vel fringilla est ullamcorper eget. Risus commodo viverra maecenas accumsan lacus vel facilisis. Velit scelerisque in dictum non. Facilisi cras fermentum odio eu feugiat pretium nibh ipsum. Dignissim sodales ut eu sem. Quam quisque id diam vel quam elementum pulvinar etiam. Neque laoreet suspendisse interdum consectetur libero id faucibus. Neque aliquam vestibulum morbi blandit cursus risus at ultrices. Ac placerat vestibulum lectus mauris ultrices eros. Sollicitudin ac orci phasellus egestas tellus rutrum tellus pellentesque. Nibh tortor id aliquet lectus proin nibh nisl. Mattis rhoncus urna neque viverra justo nec ultrices dui sapien. Sem viverra aliquet eget sit amet tellus cras adipiscing. Sed enim ut sem viverra aliquet eget. Lectus arcu bibendum at varius vel pharetra vel turpis. \n Non odio euismod lacinia at quis risus. In arcu cursus euismod quis viverra nibh cras. Ac tortor dignissim convallis aenean et tortor at. Euismod in pellentesque massa placerat duis ultricies. Enim diam vulputate ut pharetra. Non nisi est sit amet facilisis magna etiam tempor. Phasellus vestibulum lorem sed risus ultricies tristique nulla aliquet. Urna nunc id cursus metus aliquam eleifend. Condimentum id venenatis a condimentum vitae sapien pellentesque habitant morbi. In aliquam sem fringilla ut morbi tincidunt. Posuere ac ut consequat semper viverra. Id volutpat lacus laoreet non curabitur gravida arcu ac. Lacus suspendisse faucibus interdum posuere lorem ipsum dolor sit. Tincidunt vitae semper quis lectus nulla at volutpat. Ipsum consequat nisl vel pretium lectus quam id. Aliquet bibendum enim facilisis gravida neque convallis. Nullam eget felis eget nunc lobortis mattis aliquam faucibus purus. Etiam sit amet nisl purus in mollis nunc sed id. Varius sit amet mattis vulputate enim nulla aliquet. \n A diam sollicitudin tempor id eu nisl nunc mi. Volutpat odio facilisis mauris sit. Vulputate odio ut enim blandit. Semper viverra nam libero justo laoreet sit amet. In mollis nunc sed id semper risus in hendrerit. Ullamcorper a lacus vestibulum sed arcu non odio euismod lacinia. In nibh mauris cursus mattis molestie a. Id diam vel quam elementum pulvinar etiam. Tortor posuere ac ut consequat semper viverra nam libero justo. Vitae auctor eu augue ut. Augue mauris augue neque gravida. Blandit turpis cursus in hac habitasse platea. Mi quis hendrerit dolor magna eget est lorem ipsum dolor. Ante metus dictum at tempor. Donec ultrices tincidunt arcu non sodales neque. Natoque penatibus et magnis dis parturient montes nascetur. Pellentesque adipiscing commodo elit at imperdiet dui accumsan sit."),
              SizedBox(
                height: 16.0,
              ),
              ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    title: Text("Official Website"),
                    trailing: Icon(Icons.navigate_next),
                  ),
                  ListTile(
                    title: Text("Customer Support"),
                    trailing: Icon(Icons.navigate_next),
                  ),
                  ListTile(
                    title: Text("Privacy Policy"),
                    trailing: Icon(Icons.navigate_next),
                  ),
                  ListTile(
                    title: Text("Refund Policy"),
                    trailing: Icon(Icons.navigate_next),
                  ),
                  ListTile(
                    title: Text("Terms of Service"),
                    trailing: Icon(Icons.navigate_next),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
