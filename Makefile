MODULES=sprite objects projectile gui enemy stage utils collisions dialogue authors
OBJECTS=$(MODULES:=.cmo)
MLS=$(MODULES:=.ml)
MLIS=$(MODULES:=.mli)
TEST=test.byte
MAIN=demo.byte
OCAMLBUILD=ocamlbuild -use-ocamlfind
PKGS=unix,oUnit,str,yojson,graphics,camlimages.core,camlimages.png,camlimages.graphics,camlimages.gif

default: build
	utop

build:
	$(OCAMLBUILD) $(OBJECTS)

test:
	$(OCAMLBUILD) -tag 'debug' $(TEST) && ./$(TEST)

play:
	$(OCAMLBUILD) $(MAIN) && ./$(MAIN)

check:
	bash checkenv.sh
	
# finalcheck: check
# 	bash checkzip.sh
# 	bash finalcheck.sh

zip: 
	zip camlraiders.zip *.ml* _tags Makefile ./assets/images/* INSTALL.txt
	
docs: docs-public docs-private
	
docs-public: build
	mkdir -p doc.public
	ocamlfind ocamldoc -I _build -package $(PKGS) \
		-html -stars -d doc.public $(MLIS)

docs-private: build
	mkdir -p doc.private
	ocamlfind ocamldoc -I _build -package $(PKGS) \
		-html -stars -d doc.private \
		-inv-merge-ml-mli -m A -hide-warnings $(MLIS) $(MLS)

clean:
	ocamlbuild -clean
	rm -rf doc.public doc.private camelraiders.zip
