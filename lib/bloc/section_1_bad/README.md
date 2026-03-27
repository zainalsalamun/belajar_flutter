# Dokumentasi Bloc Section 1: Bad Practice (Logic di UI)

Halaman ini mendemonstrasikan bagaimana mencampurkan logic state (seperti `counter++`) dengan UI Widget dalam pendekatan standar `setState` (tanpa menggunakan Bloc pattern). Ini disebut *Bad Practice* apabila aplikasi berskala menengah/besar karena sulit di-maintain, ditesting, dan dimodifikasi.