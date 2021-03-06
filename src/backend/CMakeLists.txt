# Copyright 2017 The NXT Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set(COMMON_DIR ${CMAKE_CURRENT_SOURCE_DIR}/common)
set(METAL_DIR ${CMAKE_CURRENT_SOURCE_DIR}/metal)
set(NULL_DIR ${CMAKE_CURRENT_SOURCE_DIR}/null)
set(OPENGL_DIR ${CMAKE_CURRENT_SOURCE_DIR}/opengl)
set(D3D12_DIR ${CMAKE_CURRENT_SOURCE_DIR}/d3d12)
set(TESTS_DIR ${CMAKE_CURRENT_SOURCE_DIR}/tests)

list(APPEND BACKEND_SOURCES
    ${COMMON_DIR}/BindGroup.cpp
    ${COMMON_DIR}/BindGroup.h
    ${COMMON_DIR}/BindGroupLayout.cpp
    ${COMMON_DIR}/BindGroupLayout.h
    ${COMMON_DIR}/BitSetIterator.h
    ${COMMON_DIR}/Builder.cpp
    ${COMMON_DIR}/Builder.h
    ${COMMON_DIR}/Buffer.cpp
    ${COMMON_DIR}/Buffer.h
    ${COMMON_DIR}/CommandAllocator.cpp
    ${COMMON_DIR}/CommandAllocator.h
    ${COMMON_DIR}/CommandBuffer.cpp
    ${COMMON_DIR}/CommandBuffer.h
    ${COMMON_DIR}/DepthStencilState.cpp
    ${COMMON_DIR}/DepthStencilState.h
    ${COMMON_DIR}/CommandBufferStateTracker.cpp
    ${COMMON_DIR}/CommandBufferStateTracker.h
    ${COMMON_DIR}/Device.cpp
    ${COMMON_DIR}/Device.h
    ${COMMON_DIR}/Forward.h
    ${COMMON_DIR}/Framebuffer.cpp
    ${COMMON_DIR}/Framebuffer.h
    ${COMMON_DIR}/InputState.cpp
    ${COMMON_DIR}/InputState.h
    ${COMMON_DIR}/Math.cpp
    ${COMMON_DIR}/Math.h
    ${COMMON_DIR}/PerStage.cpp
    ${COMMON_DIR}/PerStage.h
    ${COMMON_DIR}/Pipeline.cpp
    ${COMMON_DIR}/Pipeline.h
    ${COMMON_DIR}/PipelineLayout.cpp
    ${COMMON_DIR}/PipelineLayout.h
    ${COMMON_DIR}/Queue.cpp
    ${COMMON_DIR}/Queue.h
    ${COMMON_DIR}/RenderPass.cpp
    ${COMMON_DIR}/RenderPass.h
    ${COMMON_DIR}/RefCounted.cpp
    ${COMMON_DIR}/RefCounted.h
    ${COMMON_DIR}/Sampler.cpp
    ${COMMON_DIR}/Sampler.h
    ${COMMON_DIR}/SerialQueue.h
    ${COMMON_DIR}/ShaderModule.cpp
    ${COMMON_DIR}/ShaderModule.h
    ${COMMON_DIR}/Texture.cpp
    ${COMMON_DIR}/Texture.h
    ${COMMON_DIR}/ToBackend.h
)

# OpenGL Backend

Generate(
    LIB_NAME opengl_autogen
    LIB_TYPE STATIC
    PRINT_NAME "OpenGL backend autogenerated files"
    COMMAND_LINE_ARGS
        ${GENERATOR_COMMON_ARGS}
        -T opengl
)
target_link_libraries(opengl_autogen glfw glad nxtcpp)
target_include_directories(opengl_autogen PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
target_include_directories(opengl_autogen PUBLIC ${GENERATED_DIR})
SetCXX14(opengl_autogen)
SetPIC(opengl_autogen)

list(APPEND BACKEND_SOURCES
    ${OPENGL_DIR}/CommandBufferGL.cpp
    ${OPENGL_DIR}/CommandBufferGL.h
    ${OPENGL_DIR}/DepthStencilStateGL.cpp
    ${OPENGL_DIR}/DepthStencilStateGL.h
    ${OPENGL_DIR}/OpenGLBackend.cpp
    ${OPENGL_DIR}/OpenGLBackend.h
    ${OPENGL_DIR}/PersistentPipelineStateGL.cpp
    ${OPENGL_DIR}/PersistentPipelineStateGL.h
    ${OPENGL_DIR}/PipelineGL.cpp
    ${OPENGL_DIR}/PipelineGL.h
    ${OPENGL_DIR}/PipelineLayoutGL.cpp
    ${OPENGL_DIR}/PipelineLayoutGL.h
    ${OPENGL_DIR}/SamplerGL.cpp
    ${OPENGL_DIR}/SamplerGL.h
    ${OPENGL_DIR}/ShaderModuleGL.cpp
    ${OPENGL_DIR}/ShaderModuleGL.h
    ${OPENGL_DIR}/TextureGL.cpp
    ${OPENGL_DIR}/TextureGL.h
)

# Null backend
Generate(
    LIB_NAME null_autogen
    LIB_TYPE STATIC
    PRINT_NAME "Null backend autogenerated files"
    COMMAND_LINE_ARGS
        ${GENERATOR_COMMON_ARGS}
        -T null
)
target_link_libraries(null_autogen nxtcpp)
target_include_directories(null_autogen PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
target_include_directories(null_autogen PUBLIC ${GENERATED_DIR})
SetCXX14(null_autogen)
SetPIC(null_autogen)

list(APPEND BACKEND_SOURCES
    ${NULL_DIR}/NullBackend.cpp
    ${NULL_DIR}/NullBackend.h
)

# Metal Backend

if (APPLE)
    Generate(
        LIB_NAME metal_autogen
        LIB_TYPE STATIC
        PRINT_NAME "Metal backend autogenerated files"
        COMMAND_LINE_ARGS
            ${GENERATOR_COMMON_ARGS}
            -T metal
    )
    target_link_libraries(metal_autogen glfw glad nxtcpp "-framework QuartzCore" "-framework Metal")
    target_include_directories(metal_autogen PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
    target_include_directories(metal_autogen PUBLIC ${GENERATED_DIR})
    SetCXX14(metal_autogen)
    SetPIC(metal_autogen)

    list(APPEND BACKEND_SOURCES
        ${METAL_DIR}/BufferMTL.mm
        ${METAL_DIR}/BufferMTL.h
        ${METAL_DIR}/CommandBufferMTL.mm
        ${METAL_DIR}/CommandBufferMTL.h
        ${METAL_DIR}/DepthStencilStateMTL.mm
        ${METAL_DIR}/DepthStencilStateMTL.h
        ${METAL_DIR}/InputStateMTL.mm
        ${METAL_DIR}/InputStateMTL.h
        ${METAL_DIR}/MetalBackend.mm
        ${METAL_DIR}/MetalBackend.h
        ${METAL_DIR}/PipelineMTL.mm
        ${METAL_DIR}/PipelineMTL.h
        ${METAL_DIR}/PipelineLayoutMTL.mm
        ${METAL_DIR}/PipelineLayoutMTL.h
        ${METAL_DIR}/ResourceUploader.mm
        ${METAL_DIR}/ResourceUploader.h
        ${METAL_DIR}/SamplerMTL.mm
        ${METAL_DIR}/SamplerMTL.h
        ${METAL_DIR}/ShaderModuleMTL.mm
        ${METAL_DIR}/ShaderModuleMTL.h
        ${METAL_DIR}/TextureMTL.mm
        ${METAL_DIR}/TextureMTL.h
    )
endif()

# D3D12 Backend

if (WIN32)
    Generate(
        LIB_NAME d3d12_autogen
        LIB_TYPE STATIC
        PRINT_NAME "D3D12 backend autogenerated files"
        COMMAND_LINE_ARGS
            ${GENERATOR_COMMON_ARGS}
            -T d3d12
    )
    # WIN10_SDK_PATH will be something like C:\Program Files (x86)\Windows Kits\10
    get_filename_component(WIN10_SDK_PATH "[HKEY_LOCAL_MACHINE\\SOFTWARE\\WOW6432Node\\Microsoft\\Microsoft SDKs\\Windows\\v10.0;InstallationFolder]" ABSOLUTE CACHE)

    # TEMP_WIN10_SDK_VERSION will be something like ${CMAKE_CURRENT_SOURCE_DIR}\10.0.14393 or ${CMAKE_CURRENT_SOURCE_DIR}\10.0.14393.0
    get_filename_component(TEMP_WIN10_SDK_VERSION "[HKEY_LOCAL_MACHINE\\SOFTWARE\\WOW6432Node\\Microsoft\\Microsoft SDKs\\Windows\\v10.0;ProductVersion]" ABSOLUTE CACHE)

    # strip off ${CMAKE_CURRENT_SOURCE_DIR} to get just the version number
    get_filename_component(WIN10_SDK_VERSION ${TEMP_WIN10_SDK_VERSION} NAME)
    # WIN10_SDK_VERSION will be something like 10.0.14393 or 10.0.14393.0; we need the one that matches the directory name.
    if (IS_DIRECTORY "${WIN10_SDK_PATH}/Include/${WIN10_SDK_VERSION}.0")
        set(WIN10_SDK_VERSION "${WIN10_SDK_VERSION}.0")
    endif()

    # Find the d3d12 and dxgi include path, it will typically look something like this.
    # C:\Program Files (x86)\Windows Kits\10\Include\10.0.10586.0\um\d3d12.h
    # C:\Program Files (x86)\Windows Kits\10\Include\10.0.10586.0\shared\dxgi1_4.h
    find_path(D3D12_INCLUDE_DIR     # Set variable D3D12_INCLUDE_DIR
        d3d12.h                     # Find a path with d3d12.h
        HINTS "${WIN10_SDK_PATH}/Include/${WIN10_SDK_VERSION}/um"
        DOC "path to WIN10 SDK header files"
        HINTS
    )

    find_path(DXGI_INCLUDE_DIR      # Set variable DXGI_INCLUDE_DIR
        dxgi1_4.h                   # Find a path with dxgi1_4.h
        HINTS "${WIN10_SDK_PATH}/Include/${WIN10_SDK_VERSION}/shared"
        DOC "path to WIN10 SDK header files"
        HINTS
    )

    if (CMAKE_GENERATOR MATCHES "Visual Studio.*ARM" )
        set(WIN10_SDK_LIB_PATH ${WIN10_SDK_PATH}/Lib/${WIN10_SDK_VERSION}/um/arm)
    elseif (CMAKE_GENERATOR MATCHES "Visual Studio.*ARM64" )
        set(WIN10_SDK_LIB_PATH ${WIN10_SDK_PATH}/Lib/${WIN10_SDK_VERSION}/um/arm64)
    elseif (CMAKE_GENERATOR MATCHES "Visual Studio.*Win64" )
        set(WIN10_SDK_LIB_PATH ${WIN10_SDK_PATH}/Lib/${WIN10_SDK_VERSION}/um/x64)
    else()
        set(WIN10_SDK_LIB_PATH ${WIN10_SDK_PATH}/Lib/${WIN10_SDK_VERSION}/um/x86)
    endif()

    find_library(D3D12_LIBRARY NAMES d3d12.lib HINTS ${WIN10_SDK_LIB_PATH})
    find_library(DXGI_LIBRARY NAMES dxgi.lib HINTS ${WIN10_SDK_LIB_PATH})
    find_library(D3DCOMPILER_LIBRARY NAMES d3dcompiler.lib HINTS ${WIN10_SDK_LIB_PATH})

    set(D3D12_LIBRARIES
        ${D3D12_LIBRARY}
        ${DXGI_LIBRARY}
        ${D3DCOMPILER_LIBRARY}
    )

    target_link_libraries(d3d12_autogen glfw nxtcpp ${D3D12_LIBRARIES})
    target_include_directories(d3d12_autogen SYSTEM PRIVATE ${D3D12_INCLUDE_DIR} ${DXGI_INCLUDE_DIR})
    target_include_directories(d3d12_autogen PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
    target_include_directories(d3d12_autogen PUBLIC ${GENERATED_DIR})
    SetCXX14(d3d12_autogen)
    SetPIC(d3d12_autogen)

    list(APPEND BACKEND_SOURCES
        ${D3D12_DIR}/BufferD3D12.cpp
        ${D3D12_DIR}/BufferD3D12.h
        ${D3D12_DIR}/CommandAllocatorManager.cpp
        ${D3D12_DIR}/CommandAllocatorManager.h
        ${D3D12_DIR}/CommandBufferD3D12.cpp
        ${D3D12_DIR}/CommandBufferD3D12.h
        ${D3D12_DIR}/D3D12Backend.cpp
        ${D3D12_DIR}/D3D12Backend.h
        ${D3D12_DIR}/InputStateD3D12.cpp
        ${D3D12_DIR}/InputStateD3D12.h
        ${D3D12_DIR}/PipelineD3D12.cpp
        ${D3D12_DIR}/PipelineD3D12.h
        ${D3D12_DIR}/PipelineLayoutD3D12.cpp
        ${D3D12_DIR}/PipelineLayoutD3D12.h
        ${D3D12_DIR}/QueueD3D12.cpp
        ${D3D12_DIR}/QueueD3D12.h
        ${D3D12_DIR}/ResourceAllocator.cpp
        ${D3D12_DIR}/ResourceAllocator.h
        ${D3D12_DIR}/ResourceUploader.cpp
        ${D3D12_DIR}/ResourceUploader.h
        ${D3D12_DIR}/ShaderModuleD3D12.cpp
        ${D3D12_DIR}/ShaderModuleD3D12.h
    )
endif()

add_library(nxt_backend STATIC ${BACKEND_SOURCES})

target_link_libraries(nxt_backend opengl_autogen null_autogen glfw glad spirv-cross)
if (APPLE)
    target_link_libraries(nxt_backend metal_autogen)
endif()
if (WIN32)
    target_link_libraries(nxt_backend d3d12_autogen)
endif()
target_include_directories(nxt_backend PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
SetCXX14(nxt_backend)
