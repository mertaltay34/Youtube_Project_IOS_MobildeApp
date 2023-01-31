//
//  Note.swift
//  YouTube_Project
//
//  Created by Admin on 26.01.2023.
//

/*
 Strong Değişken : Swiftte bir değişken tanımladığınızda default olarak strong yapıdadır. Strong değişkenler eğer bir referans tipteyse reference count’u arttır.
 Weak Değişken : Eğer bir değişken weak olarak tanımlanırsa reference count’u etkilemez. Optional durumları destekler, yani uygulamanın bir bölümünde refere ettiği nesne deallocate edilirse nil değer alabilir. İçerisinde oluşturulduğu parent class deallocate edilirse silinir.
 weak referanslar optional olarak kullanılır.
 Unowned Değişken : Eğer bir değişken unowned olarak tanımlanırsa reference count’u etkilemez. Unowned değişkenlere değer atamak zorunludur. Tuttuğu nesne deallocate edilse bile bu nesnenin adresini tutmaya devam eder, yani nil setlenmez bu durumda kullanılması uygulamayı crash eder.
 Notification Center bir singleton nesnedir, yani bizim kullandığımız UIViewController’dan bağımsızdır. Eğer bir kere Notification Center’a observer eklenirse bu atama işlemi nil olana kadar varlığını sürdürmeye devam eder, hatta observerı eklediğimiz viewcontroller deallocate edilse bile. Bu durum ise memory leak oluşturur.
 Bu sorunu notification centerın addobserver closureunda capture list kullanarak çözebiliriz.
 Delegatelerin deallocate edilmesi için weak referanslarda tutulması yaygın olarak kullanılan bir yöntemdir. Böylece retain cycle oluşturma riski ortadan kalkar. Ancak tanımlanan protokoller değer(temel — primitive) veya referans tipinde olabilir bu durumda ürettiğimiz bir nesneyi weak reference olarak kullanamayız. Protokolümüzün referans tipinde olduğunu garanti etmemiz gerekir. Bu durumda protokollerimizin AnyObject’ten türetilmesini sağlarsak, delegate protokolümüzün sadece bir referans tipi olmasını garanti ederiz ve bir nesne ürettiğimizde weak reference olarak kullanmamıza olanak sağlar. Diğer bir yöntem ise delegate değişkenimizi setlediğimiz viewcontrollerda işlemlerimiz bittikten sonra tekrardan nil setlemektir.

 */
