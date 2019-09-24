import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cdr_today/widgets/actions.dart';
import 'package:cdr_today/widgets/editor.dart';
import 'package:cdr_today/navigations/args.dart';
import 'package:zefyr/zefyr.dart';

class Edit extends StatefulWidget {
  final ArticleArgs args;
  Edit({ this.args });
  
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  ZefyrController _controller;
  FocusNode _focusNode;
  bool _edit;
  
  @override
  void initState() {
    super.initState();
    _edit = true;
    final document = _loadDocument();
    _focusNode = FocusNode();
    _controller = ZefyrController(document);
  }

  @override
  dispose() {
    super.dispose();
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: _edit == true ? [
          Post(
            args: widget.args,
            update: false,
            zefyrController: _controller,
            toPreview: () => setState(() { _edit = false; })
          )
        ]: [
          More(
            args: widget.args,
            update: false,
            toEdit: () {
              setState(() { _edit = true; });
              Navigator.pop(context);
            },
            zefyrController: _controller,
          )
        ],
        elevation: 0.0,
        leading: CloseButton(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor
      ),
      body: Editor(
        focusNode: _focusNode,
        controller: _controller,
        edit: true,
      ),
    );
  }
  
  NotusDocument _loadDocument() {
    if (widget.args.edit == true) {
      return NotusDocument.fromJson(jsonDecode(widget.args.document));
    }
    
    var data = r'[{"insert":"\n","attributes":{"heading":1}}]';
    return NotusDocument.fromJson(json.decode(data) as List);
  }
}
