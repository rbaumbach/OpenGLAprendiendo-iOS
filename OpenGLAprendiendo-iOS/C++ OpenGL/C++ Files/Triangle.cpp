#include "Triangle.hpp"

GLfloat macOSTriangleVertices[] = {
    // positions          // colors
    0.5f, -0.5f, 0.0f,    1.0f, 0.0f, 0.0f,   // bottom right
    -0.5f, -0.5f, 0.0f,   0.0f, 1.0f, 0.0f,   // bottom left
    0.0f,  0.5f, 0.0f,    0.0f, 0.0f, 1.0f    // top
};

GLfloat triangleVertices[] = {
    // positions          // colors
    0.5f, -0.25f, 0.0f,     1.0f, 0.0f, 0.0f,   // bottom right
    -0.5, -0.25, 0.0,       0.0f, 1.0f, 0.0f,   // bottom left
    0.0, 0.25, 0.0,         0.0f, 0.0f, 1.0f    // top
};

Triangle::Triangle(GLboolean isMacOS)
{
    this->isMacOS = isMacOS;
}

void Triangle::setup()
{
    if (isMacOS)
    {
        shaderManager.loadShadersFromPaths("vertex.glsl", "fragment.glsl");
    }
    else
    {
        shaderManager.loadHardcodedShaders();
    }
    
    glGenVertexArrays(1, &VAO);
    glGenBuffers(1, &VBO);

    // bind the Vertex Array Object first, then bind and set vertex buffer(s), and then configure vertex attributes(s).

    glBindVertexArray(VAO);

    glBindBuffer(GL_ARRAY_BUFFER, VBO);
    
    if(isMacOS)
    {
        glBufferData(GL_ARRAY_BUFFER, sizeof(macOSTriangleVertices), macOSTriangleVertices, GL_STATIC_DRAW);

    }
    else
    {
        glBufferData(GL_ARRAY_BUFFER, sizeof(triangleVertices), triangleVertices, GL_STATIC_DRAW);

    }
    
    // position attribute

    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(float), (void*)0);
    glEnableVertexAttribArray(0);

    // color attribute

    glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(float), (void*)(3* sizeof(float)));
    glEnableVertexAttribArray(1);

    // note that this is allowed, the call to glVertexAttribPointer registered VBO as the vertex attribute's bound vertex buffer object so afterwards we can safely unbind

    glBindBuffer(GL_ARRAY_BUFFER, 0);

    // You can unbind the VAO afterwards so other VAO calls won't accidentally modify this VAO, but this rarely happens. Modifying other
    // VAOs requires a call to glBindVertexArray anyways so we generally don't unbind VAOs (nor VBOs) when it's not directly necessary.

    glBindVertexArray(0);
}

void Triangle::teardown()
{
    glDeleteVertexArrays(1, &VAO);
    glDeleteBuffers(1, &VBO);
}

void Triangle::render()
{
    glClearColor(0.2f, 0.3f, 0.3f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);

    shaderManager.useProgram();

    // seeing as we only have a single VAO there's no need to bind it every time, but we'll do so to keep things a bit more organized
    
    glBindVertexArray(VAO);

    glDrawArrays(GL_TRIANGLES, 0, 3);
}
