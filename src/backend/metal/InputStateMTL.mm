// Copyright 2017 The NXT Authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#include "InputStateMTL.h"

#include "MetalBackend.h"

namespace backend {
namespace metal {

    namespace {
        MTLVertexFormat VertexFormatType(nxt::VertexFormat format) {
            switch (format) {
                case nxt::VertexFormat::FloatR32G32B32A32:
                    return MTLVertexFormatFloat4;
                case nxt::VertexFormat::FloatR32G32B32:
                    return MTLVertexFormatFloat3;
                case nxt::VertexFormat::FloatR32G32:
                    return MTLVertexFormatFloat2;
            }
        }

        MTLVertexStepFunction InputStepModeFunction(nxt::InputStepMode mode) {
            switch (mode) {
                case nxt::InputStepMode::Vertex:
                    return MTLVertexStepFunctionPerVertex;
                case nxt::InputStepMode::Instance:
                    return MTLVertexStepFunctionPerInstance;
            }
        }
    }

    InputState::InputState(InputStateBuilder* builder)
        : InputStateBase(builder) {
        mtlVertexDescriptor = [MTLVertexDescriptor new];

        const auto& attributesSetMask = GetAttributesSetMask();
        for (size_t i = 0; i < attributesSetMask.size(); ++i) {
            if (!attributesSetMask[i]) {
                continue;
            }
            const AttributeInfo& info = GetAttribute(i);

            auto attribDesc = [MTLVertexAttributeDescriptor new];
            attribDesc.format = VertexFormatType(info.format);
            attribDesc.offset = info.offset;
            attribDesc.bufferIndex = kMaxBindingsPerGroup + info.bindingSlot;
            mtlVertexDescriptor.attributes[i] = attribDesc;
            [attribDesc release];
        }

        const auto& inputsSetMask = GetInputsSetMask();
        for (size_t i = 0; i < inputsSetMask.size(); ++i) {
            if (!inputsSetMask[i]) {
                continue;
            }
            const InputInfo& info = GetInput(i);

            auto layoutDesc = [MTLVertexBufferLayoutDescriptor new];
            if (info.stride == 0) {
                // For MTLVertexStepFunctionConstant, the stepRate must be 0,
                // but the stride must NOT be 0, so I made up a value (256).
                layoutDesc.stepFunction = MTLVertexStepFunctionConstant;
                layoutDesc.stepRate = 0;
                layoutDesc.stride = 256;
            } else {
                layoutDesc.stepFunction = InputStepModeFunction(info.stepMode);
                layoutDesc.stepRate = 1;
                layoutDesc.stride = info.stride;
            }
            mtlVertexDescriptor.layouts[kMaxBindingsPerGroup + i] = layoutDesc;
            [layoutDesc release];
        }
    }

    InputState::~InputState() {
        [mtlVertexDescriptor release];
        mtlVertexDescriptor = nil;
    }

    MTLVertexDescriptor* InputState::GetMTLVertexDescriptor() {
        return mtlVertexDescriptor;
    }

}
}
