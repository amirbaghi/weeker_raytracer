
#include <optix.h>
#include <optixu/optixu_math_namespace.h>

#include "../lib/raydata.cuh"
#include "../lib/sampling.cuh"

// Ray state variables
rtDeclareVariable(optix::Ray, theRay, rtCurrentRay, );
rtDeclareVariable(PerRayData, thePrd, rtPayload,  );

// "Global" variables
rtDeclareVariable(rtObject, sysWorld, , );

// The point and normal of intersection
rtDeclareVariable(HitRecord, hitRecord, attribute hitRecord, );

// Material variables
rtDeclareVariable(rtCallableProgramId<float3(float, float, float3)>, sampleTexture, , );

inline __device__ float3 emitted() {
    return make_float3(0.f, 0.f, 0.f);
}

inline __device__ float scatteringPdf() {
  return false;
}

RT_PROGRAM void closestHit()
{
    float3 scatterDirection = randomInUnitSphere(thePrd.seed);

    thePrd.scatterEvent = Ray_Hit;
    thePrd.scattered_origin = hitRecord.point;
    thePrd.scattered_direction = scatterDirection;
    thePrd.emitted = emitted();
    thePrd.attenuation = sampleTexture(hitRecord.u, hitRecord.v, hitRecord.point);
    thePrd.scattered_pdf = scatteringPdf();
}
