#include <iostream>
#include <EGL/egl.h>
#ifdef OPENGLES2
    #include <GLES2/gl2.h>
#else
    #include <GLES3/gl3.h>
#endif

int main()
{
    std::cout<<"say something!"<<std::endl;
    std::cout<<eglGetError()<<glGetError()<<std::endl;
    return 0;
}
