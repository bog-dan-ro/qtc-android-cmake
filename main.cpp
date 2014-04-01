#include <QApplication>
#include <QLabel>

int da_drumu_lu_main(int argc, char ** argv)
{
    QApplication a(argc, argv);
    QLabel l;
    l.setText("Qt on Android");
    l.show();
    return a.exec();
}

int main(int argc, char ** argv)
{
    return da_drumu_lu_main(argc, argv);
}
